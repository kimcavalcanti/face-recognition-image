FROM ubuntu:16.04

RUN apt-get update && \
  apt-get install -y software-properties-common vim && \
  add-apt-repository ppa:jonathonf/python-3.6
RUN apt-get update -y

RUN apt-get install -y build-essential python3.6 python3.6-dev python3-pip python3.6-venv && \
        apt-get install -y git

# update pip
RUN python3.6 -m pip install pip --upgrade && \
        python3.6 -m pip install wheel

RUN apt-get update && \
        apt-get install -y \
        build-essential \
        cmake \
        git \
        wget \
        unzip \
        yasm \
        pkg-config \
        libswscale-dev \
        libtbb2 \
        libtbb-dev \
        libjpeg-dev \
        libpng-dev \
        libtiff-dev \
        libavformat-dev \
        libpq-dev

RUN pip install numpy==1.15.0

WORKDIR /
ENV OPENCV_VERSION="3.4.2"
RUN wget https://github.com/opencv/opencv/archive/${OPENCV_VERSION}.zip \
&& unzip ${OPENCV_VERSION}.zip \
&& mkdir /opencv-${OPENCV_VERSION}/cmake_binary \
&& cd /opencv-${OPENCV_VERSION}/cmake_binary \
&& cmake -DBUILD_TIFF=ON \
  -DBUILD_opencv_java=OFF \
  -DWITH_CUDA=OFF \
  -DWITH_OPENGL=ON \
  -DWITH_OPENCL=ON \
  -DWITH_IPP=ON \
  -DWITH_TBB=ON \
  -DWITH_EIGEN=ON \
  -DWITH_V4L=ON \
  -DBUILD_TESTS=OFF \
  -DBUILD_PERF_TESTS=OFF \
  -DCMAKE_BUILD_TYPE=RELEASE \
  -DCMAKE_INSTALL_PREFIX=$(python3.6 -c "import sys; print(sys.prefix)") \
  -DPYTHON_EXECUTABLE=$(which python3.6) \
  -DPYTHON_INCLUDE_DIR=$(python3.6 -c "from distutils.sysconfig import get_python_inc; print(get_python_inc())") \
  -DPYTHON_PACKAGES_PATH=$(python3.6 -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())") \
  .. \
&& make install \
&& rm /${OPENCV_VERSION}.zip \
&& rm -r /opencv-${OPENCV_VERSION}

RUN wget https://github.com/evdcush/TensorFlow-wheels/releases/download/tf-1.8-cpu-westmere/tensorflow-1.8.0-cp36-cp36m-linux_x86_64.whl && \
        pip install --no-cache-dir tensorflow-1.8.0-cp36-cp36m-linux_x86_64.whl

RUN pip install opencv-contrib-python && \
        pip install pytesseract && \
        pip install flask && \
        pip install imageio && \
        pip install pillow && \
        pip install brotli && \
        pip install spacy && \
        pip install nltk && \
        pip install imutils && \
        pip install CMake && \
        pip install absl-py==0.1.10 && \
        pip install appnope==0.1.0 && \
        pip install bleach==1.5.0 && \
        pip install cycler==0.10.0 && \
        pip install decorator==4.2.1 && \
        pip install dlib==19.9.0 && \
        pip install entrypoints==0.2.3 && \
        pip install h5py==2.7.1 && \
        pip install html5lib==0.9999999 && \
        pip install ipykernel==4.8.0 && \
        pip install ipython==6.2.1 && \
        pip install ipython-genutils==0.2.0 && \
        pip install ipywidgets==7.1.1 && \
        pip install jedi==0.11.1 && \
        pip install Jinja2==2.10 && \
        pip install jsonschema==2.6.0 && \
        pip install jupyter==1.0.0 && \
        pip install jupyter-client==5.2.2 && \
        pip install jupyter-console==5.2.0 && \
        pip install jupyter-core==4.4.0 && \
        pip install Keras==2.2.4 && \
        pip install Markdown==2.6.11 && \
        pip install MarkupSafe==1.0 && \
        pip install matplotlib==2.1.2 && \
        pip install mistune==0.8.3 && \
        pip install nbconvert==5.3.1 && \
        pip install nbformat==4.4.0 && \
        pip install notebook==5.4.0 && \
        pip install pandocfilters==1.4.2 && \
        pip install parso==0.1.1 && \
        pip install pexpect==4.3.1 && \
        pip install pickleshare==0.7.4 && \
        pip install prompt-toolkit==1.0.15 && \
        pip install protobuf==3.6.1 && \
        pip install ptyprocess==0.5.2 && \
        pip install Pygments==2.2.0 && \
        pip install pyparsing==2.2.0 && \
        pip install python-dateutil==2.6.1 && \
        pip install pytz==2017.3 && \
        pip install PyYAML==3.12 && \
        pip install pyzmq==16.0.4 && \
        pip install qtconsole==4.3.1 && \
        pip install scikit-learn==0.19.1 && \
        pip install scipy==1.0.0 && \
        pip install Send2Trash==1.4.2 && \
        pip install simplegeneric==0.8.1 && \
        pip install six==1.11.0 && \
        pip install tensorflow-tensorboard==1.5.1 && \
        pip install terminado==0.8.1 && \
        pip install testpath==0.3.1 && \
        pip install tornado==4.5.3 && \
        pip install traitlets==4.3.2 && \
        pip install wcwidth==0.1.7 && \
        pip install Werkzeug==0.14.1 && \
        pip install widgetsnbextension==3.1.3 && \
        pip install elasticsearch && \
        pip install requests

RUN python3.6 -m spacy download pt


RUN apt-get update && \
        apt-get install -y \
        tesseract-ocr
        
RUN apt-get update && \
        apt-get install -y \
        libhdf5-dev

RUN apt-get update && \
        apt-get install -y \
        libhdf5-serial-dev \
        libqtgui4 \
        libqt4-test