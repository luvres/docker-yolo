## YOLO for Darknet with CUDA and OpenCV 
-----
### Run
```
git clone https://github.com/AlexeyAB/darknet.git

cd darknet/

wget -c https://pjreddie.com/media/files/yolov3.weights -O yolov3.weights
```
```
docker run --rm --runtime=nvidia --name Darknet \
--mount type=bind,src=$PWD,dst=/root \
--workdir=/root \
-ti izone/yolo:cuda-opencv bash -c "\
darknet detector test cfg/coco.data cfg/yolov3.cfg yolov3.weights data/dog.jpg"
```
### Build
```
cat libs-cuda.tar.xz.part-a* > libs-cuda.tar.xz

docker build izone/yolo:cuda-opencv .
```
