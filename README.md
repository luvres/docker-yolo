## YOLO Environment
### CUDA 10.2 (cudnn7)
### OpenCV 4.2.0 with cuda suport
### Anaconda 2019.10 (Python 3.7.4)
-----
### Run
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
docker run --rm --runtime=nvidia --name OpenCV \
--net=host \
--env=DISPLAY=unix$DISPLAY \
--volume=/tmp/.X11-unix \
--volume=$HOME/.Xauthority:/root/.Xauthority \
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
docker run --rm --runtime=nvidia --name OpenCV \
--publish=8888:8888 \
--mount type=bind,src=$PWD,dst=/root \
--workdir=/root \
-ti izone/yolo:cuda-opencv-py3-jupyter-dev \
bash -c ""
```



```
git clone https://github.com/AlexeyAB/darknet.git

cd darknet/

wget -c https://pjreddie.com/media/files/yolov3.weights -O yolov3.weights
```
```
docker run --rm --runtime=nvidia --name Darknet \
--mount type=bind,src=$PWD,dst=/root \
--workdir=/root \
-ti izone/yolo:cuda-opencv-py3-jupyter bash -c "\
./darknet detector test cfg/coco.data cfg/yolov3.cfg yolov3.weights data/dog.jpg"
```
-----
### Build
```
docker build -t izone/yolo:cuda-opencv-py3-jupyter-dev .
```
