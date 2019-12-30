## YOLO for Darknet with CUDA and OpenCV 
-----
### Run
```
docker run --rm --runtime=nvidia --name Darknet \
--mount type=bind,src=$PWD,dst=/root \
--workdir=/root \
-ti izone/yolo:cuda-opencv bash
```
### Build
```
docker build izone/yolo:cuda-opencv .
```
