FROM ubuntu
MAINTAINER James Howe
LABEL Description="Image for running scRNA-seq pseudoalignment and quantification using Kallisto and BUStools"

# install dependencies

RUN apt-get update && apt-get install -y \
  build-essential \
  cmake \
  make \
  zlib1g-dev \
  autoconf \
  libhdf5-dev \
  git \
  python

# install/build Kallisto and BUStools

RUN git clone https://github.com/pachterlab/kallisto.git
RUN cd kallisto/ext/htslib && autoheader && autoconf
RUN mkdir kallisto/build
RUN cd kallisto/build && cmake .. && make && make install

RUN git clone --single-branch --branch devel https://github.com/BUStools/bustools.git
RUN mkdir bustools/build
RUN cd bustools/build && cmake .. && make && make install
