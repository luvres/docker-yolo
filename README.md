## YOLO Environment
### CUDA 10.2 (cudnn7)
### OpenCV 4.2.0 with cuda suport
### Anaconda 2019.10 (Python 3.7.4)
-----
### Run

#### Darknet - AlexeyAB
```
git clone https://github.com/AlexeyAB/darknet.git

cd darknet
```
```
docker run --rm --runtime=nvidia --name OpenCV \
--mount type=bind,src=$PWD,dst=/root/notebooks \
--workdir=/root \
-ti izone/yolo:cuda-opencv-py3-jupyter-dev bash
```
```
mkdir build-release && cd build-release

cmake ..

make

cp darknet .. && cd ..

wget -c https://pjreddie.com/media/files/yolov3.weights
```
```
./darknet detector test cfg/coco.data cfg/yolov3.cfg yolov3.weights data/dog.jpg
```

#### Darkflow
```
git clone https://github.com/thtrieu/darkflow.git

cd darkflow

mkdir bin

wget -c https://pjreddie.com/media/files/yolov2.weights -O ./bin/yolov2.weights

[ download a videofile.mp4 that you want to process ]
```
```
docker run --rm --runtime=nvidia --name OpenCV \
--publish=8888:8888 \
--mount type=bind,src=$PWD,dst=/root/notebooks \
--workdir=/root \
-ti izone/yolo:cuda-opencv-py3-jupyter-dev \
jupyter notebook \
	--allow-root \
	--no-browser \
	--ip=0.0.0.0 \
	--port=8888 \
	--notebook-dir=/root/notebooks \
	--NotebookApp.token=''
```
```
http://localhost:8888/
```
```
-> In the noteboook cells

!pip install tensorflow-gpu==1.15

!python setup.py build_ext --inplace

python flow --model cfg/yolo.cfg --load bin/yolo.weights --demo videofile.mp4 --gpu 1.0 --saveVideo
```

#### With Display add
```
--net=host \
--env=DISPLAY=unix$DISPLAY \
--volume=/tmp/.X11-unix \
--volume=$HOME/.Xauthority:/root/.Xauthority \
```

-----
### Build
```
docker build -t izone/yolo:cuda-opencv-py3-jupyter-dev .

docker build -t izone/yolo:cuda10.2-conda2019.10-ocv4.2 -f Dockerfile_cuda10.2-conda2019.10-ocv4.2 .

docker build -t izone/yolo:cuda10.2-conda2019.10-ocv4.2 -f Dockerfile_cuda10.2-conda2020.11-ocv4.2 .


```
