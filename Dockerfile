
ARG JUPYTER_TAG=2025-10-20
ARG UV_VERSION=0.7
ARG PLUGIN_NAME="PLUGIN"
ARG PYTHON_VERSION=3.12

FROM ghcr.io/astral-sh/uv:${UV_VERSION} AS uv_image

FROM quay.io/jupyter/scipy-notebook:${JUPYTER_TAG} AS scipy_notebook

ENV UV_PROJECT_ENVIRONMENT=/opt/conda \
    UV_FROZEN=1

# https://github.com/hadolint/hadolint/wiki/DL4006
# https://github.com/koalaman/shellcheck/wiki/SC3014
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

ENV DEFAULT_USER "jovyan"
USER root

# Define environment variable
ENV HOME=/home/${DEFAULT_USER}

COPY . ${HOME}/${PLUGIN_NAME}

WORKDIR $HOME/${PLUGIN_NAME}

COPY --from=uv_image /uv /bin/uv

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
      git \
      # clean cache and logs
      && rm -rf /var/lib/apt/lists/* /var/log/* /var/tmp/* ~/.npm


RUN --mount=type=cache,target=/root/.cache/uv \
    uv sync  --extra north_dependencies --extra nomad

WORKDIR $HOME

RUN rm -rf ${HOME}/${PLUGIN_NAME}

# copy north examples
COPY ./north_examples ${HOME}/north_examples

RUN uid=$(id -u ${DEFAULT_USER}) && \
    gid=$(id -g ${DEFAULT_USER}) && \
    chown -R $uid:$gid ${HOME}

# remove the PLUGIN folder to reduce image size
USER ${DEFAULT_USER}
