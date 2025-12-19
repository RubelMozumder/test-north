
ARG JUPYTER_TAG=2025-10-20
ARG UV_VERSION=0.9
ARG PLUGIN_NAME="PLUGIN"
ARG PYTHON_VERSION=3.12
FROM ghcr.io/astral-sh/uv:${UV_VERSION} AS uv_stage

FROM quay.io/jupyter/scipy-notebook:${JUPYTER_TAG} AS scipy_notebook

# https://github.com/hadolint/hadolint/wiki/DL4006
# https://github.com/koalaman/shellcheck/wiki/SC3014
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

COPY --from=uv_stage /uv /uvx /bin/

USER root

# Define environment variables
# With pre-exinsting NB_USER="jovyan" and NB_UID=100, NB_GID=1000
ENV HOME=/home/${NB_USER} 
ARG PLUGIN_NAME

RUN apt-get update \
 && apt-get install --yes --quiet --no-install-recommends \
      libgomp1 \
      libmagic1 \
      file \
      gcc \
      build-essential \
      curl \
      zip \
      unzip \
      git 
      # clean cache and logs

# By default scipy-notebook:2025-10-20 has node 18
# But, node > 20 needed for jupyterlab >= 4.4.10
RUN curl -fsSL https://deb.nodesource.com/setup_24.x | bash -

RUN apt-get install nodejs -y \
       && npm install -g configurable-http-proxy@^4.2.0 \
       # clean cache and logs
       && rm -rf /var/lib/apt/lists/* /var/log/* /var/tmp/* ~/.npm

# https://docs.astral.sh/uv/guides/integration/docker/#intermediate-layers
# Install dependencies
RUN --mount=type=cache,target=/root/.cache/uv \
    --mount=type=bind,source=uv.lock,target=uv.lock \
    --mount=type=bind,source=pyproject.toml,target=pyproject.toml \
    uv sync --locked --no-install-project --extra=north_dependencies --extra=nomad


COPY . $HOME/$PLUGIN_NAME

WORKDIR $HOME/$PLUGIN_NAME

# Sync the project
RUN --mount=type=cache,target=/root/.cache/uv \
    uv sync --locked --extra=north_dependencies --extra=nomad

RUN rm -rf ${HOME}/${PLUGIN_NAME}

RUN jupyter lab build --dev-build=False --minimize=False
# TODO: Uncomment the following 
RUN fix-permissions "/home/${NB_USER}" \
   && fix-permissions "${CONDA_DIR}" 

USER ${NB_USER}

WORKDIR $HOME

# copy north examples
COPY --chown=${NB_UID}:${NB_GID}  ./north_examples ${HOME}/examples

# groups: cannot find name for group ID 11320
RUN touch ${HOME}/.hushlogin

