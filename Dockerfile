FROM python:3.8

RUN apt-get update && apt-get upgrade -y 

RUN apt-get install -y bash

COPY . .

# Something like this is probably needed, see the conda note below.
# Get conda installed, we need it later
# RUN apt-get install -y wget && rm -rf /var/lib/apt/lists/*
# RUN wget \
#     https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh  \
#     && mkdir /root/.conda \
#     && bash Miniconda3-latest-Linux-x86_64.sh -b \
#     && rm -f Miniconda3-latest-Linux-x86_64.sh \

RUN bash scripts/setup/get_atomic_data.sh \
    scripts/setup/get_conceptnet_data.sh  \
	scripts/setup/get_model_files.sh
  

RUN pip install tensorflow 
RUN pip install ftfy==5.1

# Everything else is fine, but this use of conda is tricky.
#   probably need to use miniconda and set things up like
#   [this article](https://towardsdatascience.com/conda-pip-and-docker-ftw-d64fe638dc45)
# RUN python -m spacy download en

RUN pip install tensorboardX
RUN pip install tqdm
RUN pip install pandas
RUN pip install ipython

# These should probably be left to run at the command line
#   or in the container once it is started.
#   Perhaps a more specialized container will be created
#   that does these preloads and other setup described
#   in the COMET README.md [at](https://github.com/atcbosselut/comet-commonsense)
# RUN python scripts/data/make_atomic_data_loader.py
# RUN python scripts/data/make_conceptnet_data_loader.py


CMD [ "/bin/bash" ]
