FROM nvidia/cuda:10.2-cudnn7-devel
MAINTAINER Leonardo Loures <luvres@hotmail.com>

ENV PATH=/usr/local/anaconda3/bin:$PATH

RUN \
	apt-get update && apt-get install -y \
		curl cmake libssl-dev \
  \
  # Anaconda3
	&& ANACONDA_VERSION="2019.10" \
	&& curl -L https://repo.continuum.io/archive/Anaconda3-${ANACONDA_VERSION}-Linux-x86_64.sh \
			-o Anaconda3-${ANACONDA_VERSION}-Linux-x86_64.sh \
	&& /bin/bash Anaconda3-${ANACONDA_VERSION}-Linux-x86_64.sh -b -p /usr/local/anaconda3 \
	&& ln -s /usr/local/anaconda3/ /opt/anaconda3 \
	&& rm Anaconda3-${ANACONDA_VERSION}-Linux-x86_64.sh \
  \
	&& pip install --upgrade pip \
	&& pip install \
		tensorflow-gpu==1.15 \
  \
	&& mkdir /root/notebooks \
  \
  # cmake
	&& curl -L https://github.com/Kitware/CMake/releases/download/v3.16.2/cmake-3.16.2.tar.gz \
			| tar zxf - -C . \
	&& cd cmake-3.16.2 \
	&& cmake . \
	&& make -j$(nproc) \
	&& make install \
	&& apt-get remove -y cmake \
	&& apt-get autoremove -y \
	&& ln -s /usr/local/bin/cmake /usr/bin/cmake \
	&& cd && rm cmake-3.16.2 -fR \
  \
  # OpenCV
	&& curl -L https://github.com/opencv/opencv_contrib/archive/4.2.0.tar.gz \
			| tar xzf - -C /usr/local \
	&& mv /usr/local/opencv_contrib* /usr/local/opencv_contrib \
  \
	&& curl -L https://github.com/opencv/opencv/archive/4.2.0.tar.gz \
			| tar xzf - -C . && cd opencv-4.2.0/ \
	&& mkdir build && cd build \
  \
	&& apt-get install -y \
		libgflags-dev \
		libeigen3-dev \
		libavresample-dev \
		libgstreamer-plugins-base1.0-dev \
		gstreamer1.0-plugins-base-apps \
		libdc1394-22-dev \
		libgtk2.0-dev \
		libgtk-3-dev \
		libtesseract-dev \
		libavcodec-dev \
		libavformat-dev \
		libswscale-dev \
  \
	&& cmake \
		-D CMAKE_BUILD_TYPE=Release \
		-D CMAKE_INSTALL_PREFIX=/usr/local \
		-D OPENCV_EXTRA_MODULES_PATH=/usr/local/opencv_contrib/modules \
		-D BUILD_opencv_python3=ON \
		-D WITH_FFMPEG=ON \
		-D WITH_CUDA=ON \
		-D CUDA_TOOLKIT_ROOT_DIR=/usr/local/cuda-10.2/ \
		-D CUDA_ARCH_BIN='6.0 6.1 6.2 7.0 7.2 7.5' \
		-D CUDA_ARCH_PTX="" \
		-D PYTHON3_EXECUTABLE=/usr/local/anaconda3/bin/python \
		-D PYTHON3_LIBRARY=/usr/local/anaconda3/lib/libpython3.7m.so \
		-D PYTHON3_INCLUDE_DIRS=/usr/local/anaconda3/include \
		-D PYTHON3_NUMPY_INCLUDE_DIRS=/usr/local/anaconda3/lib/python3.7/site-packages/numpy/core/include \
	.. \
  \
	&& make -j$(nproc) \
	&& make install \
  \
	&& ln -s \
		/usr/local/lib/python3.7/site-packages/cv2/python-3.7/cv2.cpython-37m-x86_64-linux-gnu.so \
		/usr/local/anaconda3/lib/python3.7/site-packages/cv2.so \
  \
	&& mv /usr/local/anaconda3/lib/libfontconfig.so.1 \
		/usr/local/anaconda3/lib/libfontconfig.so.1.ORIG \
	&& mv /usr/local/anaconda3/lib/libpangoft2-1.0.so.0 \
		/usr/local/anaconda3/lib/libpangoft2-1.0.so.0.ORIG \
	&& mv /usr/local/anaconda3/lib/libgio-2.0.so.0 \
		/usr/local/anaconda3/lib/libgio-2.0.so.0.ORIG \
  \
	&& ln -s /usr/lib/x86_64-linux-gnu/libfontconfig.so.1 /usr/local/anaconda3/lib/ \
	&& ln -s /usr/lib/x86_64-linux-gnu/libpangoft2-1.0.so.0 /usr/local/anaconda3/lib/ \
	&& ln -s /usr/lib/x86_64-linux-gnu/libgio-2.0.so.0 /usr/local/anaconda3/lib/ \
  \
	&& ln -s /usr/local/cuda-10.2 /usr/local/nvidia \
	&& ln -s /usr/local/cuda-10.2/targets/x86_64-linux/lib/libcudart.so \
		/usr/local/cuda-10.2/targets/x86_64-linux/lib/libcudart.so.10.0 \
	&& ln -s /usr/local/cuda-10.2/targets/x86_64-linux/lib/libcufft.so \
		/usr/local/cuda-10.2/targets/x86_64-linux/lib/libcufft.so.10.0 \
	&& ln -s /usr/local/cuda-10.2/targets/x86_64-linux/lib/libcusolver.so \
		/usr/local/cuda-10.2/targets/x86_64-linux/lib/libcusolver.so.10.0 \
	&& ln -s /usr/local/cuda-10.2/targets/x86_64-linux/lib/libcusparse.so \
		/usr/local/cuda-10.2/targets/x86_64-linux/lib/libcusparse.so.10.0 \
	&& ln -s /usr/local/cuda-10.2/targets/x86_64-linux/lib/libcurand.so \
		/usr/local/cuda-10.2/targets/x86_64-linux/lib/libcurand.so.10.0 \
	&& ln -s /usr/local/cuda-10.2/targets/x86_64-linux/lib/libcurand.so \
		/usr/local/cuda-10.2/targets/x86_64-linux/lib/libcurand.so.10.0 \
	&& ln -s /usr/lib/x86_64-linux-gnu/libcublas.so \
		/usr/lib/x86_64-linux-gnu/libcublas.so.10.0 \
  \
	&& cd && rm opencv-4.2.0 /usr/local/opencv_contrib -fR


WORKDIR /root/notebooks

EXPOSE 8888

