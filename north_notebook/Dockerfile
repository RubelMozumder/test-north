# syntax=docker/dockerfile:1.6

ARG JUPYTER_TAG=2025-10-20
ARG UV_VERSION=0.7
ARG PLUGIN_NAME=""
ARG PYTHON_VERSION="3.11"

FROM ghcr.io/astral-sh/uv:${UV_VERSION} AS uv_image

FROM quay.io/jupyter/scipy-notebook:${JUPYTER_TAG} AS SCIPY_NOTEBOOK

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

WORKDIR $HOME

# Define environment variable
ENV HOME=/home/jovyan

COPY north_notebook/requirements.in .

# Bring uv from uv_image
COPY --from=uv_image /uv /bin/uv

RUN uv venv ${HOME}/.venv --python=${PYTHON_VERSION} \
    && source ${HOME}/.venv/bin/activate \
    && uv pip install --upgrade pip

RUN uv pip install -r requirements.in

RUN --mount=type=cache,target=/root/.cache/uv \
    --mount=type=bind,source=pyproject.toml,target=pyproject.toml \
    uv sync
# After instalation removing the requirement file
RUN rm requirements.in
