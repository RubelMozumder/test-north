
ARG JUPYTER_TAG=2025-10-20
ARG UV_VERSION=0.7
ARG PLUGIN_NAME="PLUGIN"

FROM quay.io/jupyter/scipy-notebook:${JUPYTER_TAG} AS scipy_notebook


# https://github.com/hadolint/hadolint/wiki/DL4006
# https://github.com/koalaman/shellcheck/wiki/SC3014
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Define environment variable
ENV HOME=/home/jovyan

COPY . ${HOME}/${PLUGIN_NAME}

WORKDIR $HOME/${PLUGIN_NAME}

USER root
RUN pip install .[north_dependencies]

WORKDIR $HOME

# remove the PLUGIN folder to reduce image size
RUN rm -rf ${HOME}/${PLUGIN_NAME}

USER "jovyan"