FROM nvidia/cuda:9.2-base-ubuntu16.04
# See http://bugs.python.org/issue19846
ENV LANG C.UTF-8
LABEL com.nvidia.volumes.needed="nvidia_driver"

RUN echo "deb http://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1604/x86_64 /" > /etc/apt/sources.list.d/nvidia-ml.list

RUN apt-get update && apt-get install -y --no-install-recommends \
         build-essential \
         cmake \
         git \
         curl \
         vim \
         ca-certificates \
         python-qt4 \
         libjpeg-dev \
         zip \
         unzip \
         libpng-dev &&\
     rm -rf /var/lib/apt/lists/*

ENV LD_LIBRARY_PATH /usr/local/nvidia/lib:/usr/local/nvidia/lib64
ENV PYTHON_VERSION=3.6

RUN curl -o ~/miniconda.sh -O  https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh  && \
     chmod +x ~/miniconda.sh && \
     ~/miniconda.sh -b -p /opt/conda && \
     rm ~/miniconda.sh && \
    /opt/conda/bin/conda install conda-build

ENV PATH=$PATH:/opt/conda/bin/
# Create Enviroment
COPY environment.yaml /environment.yaml
RUN conda env create -f environment.yaml

COPY . /QuaterNet
WORKDIR /QuaterNet/
# Activate Source
CMD source activate pytorch 
CMD source ~/.bashrc

RUN chmod -R a+w /QuaterNet
RUN chmod +x /QuaterNet/run.sh
WORKDIR /QuaterNet/

CMD ["./run.sh"]
