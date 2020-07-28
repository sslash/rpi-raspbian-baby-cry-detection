# Docker image for librosa on Raspberry PI

## Generate model steps
On your rasperry pi:
- clone this repo: https://github.com/giulbia/baby_cry_detection
- clone this repo
- create docker container: `docker build --tag kidcry-predictions:1.0 .`
- exec the container with bash: `docker run -it kidcry-predictions:1.10 bash`
- run the following commands:
```
python setup.py install
python baby_cry_detection/pc_main/train_set.py
python baby_cry_detection/pc_main/train_model.py
```

This should generate two files: 
`output/model/model.pkl` and `baby_cry_detection/dist/baby_cry_detection-1.1-py3.7.egg`  

## Prepare prediction steps:
`mkdir /opt/baby_cry_rpi`
`cd /opt/baby_cry_rpi`

Now put the generated files from above into this repo:  
`docker cp <container-id>:/alsa/alsa-utils-1.1.3/baby_cry_detection/dist/baby_cry_detection-1.1-py3.7.egg /opt/baby_cry_rpi/lib`  
`docker cp 66c6848fbeec:/alsa/alsa-utils-1.1.3/output/model/model.pkl /opt/baby_cry_rpi/model`

## Run predictions:
`./script/run.sh`






