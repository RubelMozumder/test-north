
ARG JUPYTER_TAG=2025-10-20
ARG UV_VERSION=0.7
ARG PLUGIN_NAME="PLUGIN"

FROM quay.io/jupyter/scipy-notebook:${JUPYTER_TAG} AS scipy_notebook


# https://github.com/hadolint/hadolint/wiki/DL4006
# https://github.com/koalaman/shellcheck/wiki/SC3014
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

ENV DEFAULT_USER "jovyan"
# Define environment variable
ENV HOME=/home/${DEFAULT_USER}

COPY . ${HOME}/${PLUGIN_NAME}

WORKDIR $HOME/${PLUGIN_NAME}

USER root
RUN pip install .[north_dependencies]

WORKDIR $HOME

RUN rm -rf ${HOME}/${PLUGIN_NAME}

# copy north examples
COPY ./north_examples ${HOME}/north_examples

RUN uid=$(id -u ${DEFAULT_USER}) && \
    gid=$(id -g ${DEFAULT_USER}) && \
    chown -R $uid:$gid ${HOME}

# remove the PLUGIN folder to reduce image size
USER ${DEFAULT_USER}
