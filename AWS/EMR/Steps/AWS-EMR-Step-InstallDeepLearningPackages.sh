#!/bin/bash


# enable debugging & set strict error trap
set -x -e


# change Home directory
export HOME=/mnt/home


# source script specifying environment variables
source ~/.EnvVars


# change directory to Temp folder to install NVIDIA driver & CUDA toolkit
cd $TMPDIR


# install NVIDIA driver
# (ref: http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using_cluster_computing.html#install-nvidia-driver)
# G2 Instances
# Product Type: GRID
# Product Series: GRID Series
# Product: GRID K520
# Operating System: Linux 64-bit
# Recommended/Beta: Recommended/Certified
wget http://us.download.nvidia.com/XFree86/Linux-x86_64/358.16/NVIDIA-Linux-x86_64-358.16.run
set +e
sudo sh NVIDIA-Linux-x86_64-358.16.run --silent --kernel-source-path $KERNEL_SOURCE_PATH --tmpdir $TMPDIR
set -e


# install CUDA toolkit
wget http://developer.download.nvidia.com/compute/cuda/7.5/Prod/local_installers/cuda_7.5.18_linux.run
sudo sh cuda_7.5.18_linux.run --silent --driver --toolkit --toolkitpath $CUDA_ROOT --extract $TMPDIR --kernel-source-path $KERNEL_SOURCE_PATH --tmpdir $TMPDIR
sudo sh cuda-linux64-rel-7.5.18-19867135.run --noprompt --prefix $CUDA_ROOT --tmpdir $TMPDIR

# add CUDA executables & libraries to Path
# instructions: Please make sure that
# -   PATH includes /mnt/cuda-7.5/bin
# -   LD_LIBRARY_PATH includes /mnt/cuda-7.5/lib64, or,
# add /mnt/cuda-7.5/lib64 to /etc/ld.so.conf and run ldconfig as root
echo "$CUDA_ROOT/lib64" > cuda.conf
echo "$CUDA_ROOT/lib"  >> cuda.conf
sudo mv cuda.conf /etc/ld.so.conf.d/
sudo ldconfig

# create symbolic links for NVCC
sudo ln -s $CUDA_ROOT/bin/nvcc /usr/bin/nvcc

# copy link stubs (?) to /usr/bin directory
sudo cp -r $CUDA_ROOT/bin/crt/ /usr/bin/


# change directory to Programs directory
cd $PROGRAMS_DIR


# install CUDA-related packages
git clone --recursive http://git.tiker.net/trees/pycuda.git
cd pycuda
sudo python configure.py --cuda-root=$CUDA_ROOT
set +e
sudo make install
set -e
cd ..
sudo rm -r pycuda

# sudo pip install git+https://github.com/cudamat/cudamat.git   installation fails

set +e
sudo pip install --upgrade SciKit-CUDA
set -e

sudo pip install GNumPy


# install Theano
sudo pip install --upgrade Theano
# download .TheanoRC into new Home directory
cd ~
wget $GITHUB_REPO_RAW_PATH/.config/$THEANORC_SCRIPT_NAME
dos2unix $THEANORC_SCRIPT_NAME
cd $PROGRAMS_DIR


# install Deep Learning packages
sudo pip install --upgrade git+git://github.com/mila-udem/fuel.git
sudo pip install --upgrade git+git://github.com/mila-udem/blocks.git

set +e
sudo pip install --upgrade Brainstorm[all]
set -e

sudo pip install --upgrade Chainer
git clone https://github.com/akrizhevsky/cuda-convnet2
# sudo pip install --upgrade DeepCL   need OpenCL
sudo pip install --upgrade DeepDish
sudo pip install --upgrade git+git://github.com/dirkneumann/deepdist.git

git clone https://github.com/andersbll/cudarray
cd cudarray
make
sudo make install
sudo python setup.py install
cd ..
sudo rm -r cudarray
sudo pip install --upgrade git+git://github.com/andersbll/deeppy.git

sudo pip install --upgrade Deepy

git clone https://github.com/libfann/fann.git
cd fann
cmake .
sudo make install
cd ..
sudo rm -r fann
sudo pip install --upgrade FANN2

sudo pip install --upgrade FFnet

set +e
sudo pip install --upgrade Hebel
set -e

sudo pip install --upgrade Keras
sudo pip install --upgrade https://github.com/Lasagne/Lasagne/archive/master.zip
sudo pip install --upgrade Mang

git clone https://github.com/dmlc/minerva
cd minerva
sudo cp configure.in.example configure.in
# then we need to manually edit CONFIGURE.IN and run below steps
# ./build.sh
cd $PROGRAMS_DIR

sudo pip install --upgrade git+git://github.com/hycis/Mozi.git
sudo pip install --upgrade NervanaNEON
# sudo pip install --upgrade NeuralPy   skip because this downgrades NumPy
sudo pip install --upgrade NeuroLab
sudo pip install --upgrade NLPnet
# sudo pip install --upgrade git+git://github.com/zomux/nlpy.git   installation fails
sudo pip install --upgrade NN
sudo pip install --upgrade NoLearn

wget http://bitbucket.org/eigen/eigen/get/3.2.7.zip
unzip 3.2.7.zip
sudo rm 3.2.7.zip
mkdir eigen-build
cd eigen-build
cmake $PROGRAMS_DIR/eigen-eigen-b30b87236a1b
sudo make install
cd $PROGRAMS_DIR
sudo rm -r eigen*
git clone https://github.com/OpenANN/OpenANN.git
cd OpenANN
mkdir build
cd build
cmake ..
sudo make install
sudo ldconfig
cd $PROGRAMS_DIR
sudo rm -r OpenANN
sudo mv /usr/local/local/lib64/python2.7/site-packages/* /usr/local/lib64/python2.7/site-packages/

git clone https://github.com/guoding83128/OpenDL

git clone https://github.com/vitruvianscience/opendeep.git
cd opendeep
sudo python setup.py develop
cd ..

sudo pip install --upgrade PyBrain
sudo pip install --upgrade PyBrain2
sudo pip install --upgrade PyDeepLearning
sudo pip install --upgrade PyDNN

git clone git://github.com/lisa-lab/pylearn2.git
cd pylearn2
sudo python setup.py develop
cd ..

sudo pip install --upgrade PythonBrain
sudo pip install --upgrade SciKit-NeuralNetwork
sudo pip install --upgrade git+git://github.com/sklearn-theano/sklearn-theano
sudo pip install --upgrade git+git://github.com/dougefr/synapyse.git

sudo pip install --upgrade https://storage.googleapis.com/tensorflow/linux/gpu/tensorflow-0.6.0-cp27-none-linux_x86_64.whl
sudo pip install --upgrade git+git://github.com/google/skflow.git

sudo pip install --upgrade Theanets

sudo pip install --upgrade git+git://github.com/Samsung/veles.git
git clone https://github.com/Samsung/veles.znicz
