# Docker Lasagne with python 2.7 and GPU support

cuDNN 5
Python 2.7
Numpy 1.11.1
Theano 0.9.0rc3 or 1.0
Lasagne 0.2.dev1

To pull

    docker pull morosow/zvk-sample-rnn
    
 
To test (with `nvidia-docker` installed)

    nvidia-docker run --rm -v $PWD/test.py:/run.py morosow/zvk-sample-rnn python /run.py
