
ARG JUPYTER_TAG=2025-10-20
ARG UV_VERSION=0.7
ARG PLUGIN_NAME="PLUGIN"
ARG PYTHON_VERSION=3.12

FROM quay.io/jupyter/scipy-notebook:${JUPYTER_TAG} AS scipy_notebook

# https://github.com/hadolint/hadolint/wiki/DL4006
# https://github.com/koalaman/shellcheck/wiki/SC3014
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

USER root

# Define environment variables
# With pre-exinsting NB_USER="jovyan" and NB_UID=100, NB_GID=1000
ENV HOME=/home/${NB_USER} 
ARG WORK_DIR=$HOME/work
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
      git \
      # clean cache and logs
      && rm -rf /var/lib/apt/lists/* /var/log/* /var/tmp/* ~/.npm

COPY . $WORK_DIR/$PLUGIN_NAME

WORKDIR $WORK_DIR/$PLUGIN_NAME

RUN pip install .[north_dependencies,nomad]

RUN rm -rf ${WORK_DIR}/${PLUGIN_NAME}


RUN fix-permissions "/home/${NB_USER}" \
   && fix-permissions "${CONDA_DIR}" 

USER ${NB_USER}

WORKDIR $HOME

# copy north examples
COPY --chown=${NB_UID}:${NB_GID}  ./north_examples ${HOME}/north_examples
