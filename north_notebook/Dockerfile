ARG JUPYTER_TAG=2025-04-14
ARG UV_VERSION=0.7
ARG PLUGIN_NAME=""

FROM ghcr.io/astral-sh/uv:${UV_VERSION} AS uv_image

FROM jupyter/scipy-notebook:${JUPYTER_TAG} AS SCIPY_NOTEBOOK

WORKDIR $HOME

# Define environment variable
ENV HOME=/home/jovyan

# To copy pyproject.toml other requirements file in container
ADD ./../pyproject.toml .
ADD requirements.in .

# Bring uv from uv_image
COPY --from=uv_image /uv /bin/uv

# Intallation of other jupyter extension in jupyter/scipy-notebook
RUN uv pip install . -r requirements.in \
    && jupyter lab build \
    && jupyter nbextension enable --py widgetsnbextension \
    && jupyter serverextension enable jupyterlab_h5web

# After instalation removing the requirement file
RUN rm pyproject.toml