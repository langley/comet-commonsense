# See here for image contents: https://github.com/microsoft/vscode-dev-containers/tree/v0.148.1/containers/python-3-miniconda/.devcontainer/base.Dockerfile

FROM mcr.microsoft.com/vscode/devcontainers/miniconda:0-3

# [Option] Install Node.js
ARG INSTALL_NODE="true"
ARG NODE_VERSION="lts/*"
RUN if [ "${INSTALL_NODE}" = "true" ]; then su vscode -c "source /usr/local/share/nvm/nvm.sh && nvm install ${NODE_VERSION} 2>&1"; fi

# Copy environment.yml (if found) to a temp locaition so we update the environment. Also
# copy "noop.txt" so the COPY instruction does not fail if no environment.yml exists.
COPY environment.yml* .devcontainer/noop.txt /tmp/conda-tmp/
RUN if [ -f "/tmp/conda-tmp/environment.yml" ]; then /opt/conda/bin/conda env update -n base -f /tmp/conda-tmp/environment.yml; fi \
    && rm -rf /tmp/conda-tmp

# [Optional] Uncomment to install a different version of Python than the default
# RUN conda install -y python=3.6 \
#     && pip install --no-cache-dir pipx \
#     && pipx reinstall-all

# [Optional] Uncomment this section to install additional OS packages.
# RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
#     && apt-get -y install --no-install-recommends <your-package-list-here>

COPY . .

RUN bash scripts/setup/get_atomic_data.sh \
    scripts/setup/get_conceptnet_data.sh  \
	scripts/setup/get_model_files.sh
  
RUN pip install torch && \
    pip tensorflow && \
    pip install ftfy==5.1
RUN conda install -c conda-forge spacy
RUN python -m spacy download en
RUN pip install tensorboardX && \
    pip install tqdm && \
    pip install pandas && \
    pip install ipython 

# These should probably be left to run at the command line
#   or in the container once it is started.
#   Perhaps a more specialized container will be created
#   that does these preloads and other setup described
#   in the COMET README.md [at](https://github.com/atcbosselut/comet-commonsense)
# RUN python scripts/data/make_atomic_data_loader.py
# RUN python scripts/data/make_conceptnet_data_loader.py



