# Start with cuDNN base image
FROM nvidia/cuda:10.1-cudnn7-devel-ubuntu16.04

# Install git, wget, python-dev, pip, BLAS + LAPACK and other dependencies
RUN apt-get update && apt-get install -y \
  gfortran \
  git \
  wget \
  liblapack-dev \
  libopenblas-dev \
  libffi-dev \
  libsndfile1-dev \
  cmake \
  ffmpeg \
  python-dev \
  python-pip \
  software-properties-common

# Set CUDA_ROOT
ENV CUDA_ROOT /usr/local/cuda/bin

# Install Cython
RUN pip install Cython
RUN pip install --upgrade pip
RUN pip install --upgrade six
RUN pip install --upgrade matplotlib
RUN pip install --upgrade nose
RUN pip install --upgrade scipy
RUN pip install --upgrade numpy
RUN pip install --upgrade cffi
RUN pip install --upgrade pathlib
RUN pip install --upgrade sndfile
RUN pip install --upgrade scikits.audiolab
RUN pip install --upgrade tqdm

# Clone libgpuarray repo and move into it
RUN cd /root && git clone https://github.com/Theano/libgpuarray.git && cd libgpuarray && \
# Make and move into build directory
  mkdir Build && cd Build && \
# CMake
  cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr && \
# Make
  make -j"$(nproc)" && \
  make install
# Install pygpu
RUN cd /root/libgpuarray && \
  python setup.py build_ext -L /usr/lib -I /usr/include && \
  python setup.py install

# Install bleeding-edge Theano
RUN pip install --upgrade git+https://github.com/Theano/Theano.git
# Set up .theanorc for CUDA
RUN echo "[global]\ndevice=cuda\nfloatX=float32\noptimizer_including=cudnn\n[lib]\ncnmem=0.1\n[nvcc]\nfastmath=True\n[dnn]\nenabled=True\ninclude_path=/usr/local/cuda/include\nlibrary_path=/usr/local/cuda/lib64" > /root/.theanorc

# Install bleeding-edge Lasagne
RUN pip install --upgrade https://github.com/Lasagne/Lasagne/archive/master.zip
