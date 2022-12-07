# ImageJ Service


## Installation:
```bash
conda create -n imagej-service python=3.8
conda install -y -c conda-forge pyimagej=1.3.2 openjdk=8
i
```

## Usage
Download and install ImageJ or Fiji from here: https://imagej.net/software/fiji/downloads, then start the service in the terminal:

```bash
python run_imagej_service.py --imagej-dir=/home/Fiji.app --server-url=https://ai.imjoy.io
```

Keep the terminal open, now you can access the service in a jupyter notebook (in the browser) via [this link](https://jupyter.imjoy.io/lab/index.html?load=https://gist.githubusercontent.com/oeway/e446c52b0edb55ade30bcd34a098c74f/raw/hypha-quick-tour-imagej-service.ipynb&open=1).

In the above example, we used the public hypha server hosted at https://ai.imjoy.io, if you want to start your local server, follow the instructions here: https://ha.amun.ai/#/?id=getting-started

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
