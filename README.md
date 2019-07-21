# Docker Lasagne with python 2.7 and GPU support

![Docker Cloud Automated build](https://img.shields.io/docker/cloud/automated/morosow/zvk-sample-rnn.svg)
![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/morosow/zvk-sample-rnn.svg)

Ubuntu 16.04
CUDA 10.1
cuDNN 7
Python 2.7
Numpy
Bleeding Edge Theano
Bleeding Edge Lasagne

To pull

    docker pull morosow/zvk-sample-rnn
    
 
To test (with `nvidia-docker` installed)

    nvidia-docker run --rm -v $PWD/test.py:/run.py morosow/zvk-sample-rnn python /run.py
