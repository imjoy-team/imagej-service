# ImageJ Service


## Installation:
```bash
conda create -n imagej-service python=3.8
conda install -y -c conda-forge pyimagej=1.3.2 openjdk=8
i
```

## Usage
```bash
python run_imagej_service.py --imagej-dir=/home/Fiji.app --server-url=https://ai.imjoy.io
```

## Development

To test pyimagej, run:
```
Xvfb $DISPLAY -screen 0 1024x768x16 &
python3 -c 'import imagej; ij = imagej.init("/home/Fiji.app", headless=False); print(ij.getVersion()); ij.dispose()'
```

To run the docker container:
```
docker run --net=host --rm -it -v $PWD/imagej:/app hypha-app-engine_imagej:latest sh -c "python /app/run_imagej_service.py --server-url=https://ai.imjoy.io"
```
