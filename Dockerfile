FROM continuumio/miniconda3
WORKDIR /home
RUN apt-get update && apt-get install -y --no-install-recommends \
    fonts-liberation\
    libasound2\
    libatk-bridge2.0-0\
    libatk1.0-0\
    libatspi2.0-0\
    libcairo2\
    libcups2\
    libdbus-1-3\
    libdrm2\
    libgbm1\
    libglib2.0-0\
    libgtk-3-0\
    libnspr4\
    libnss3\
    libpango-1.0-0\
    libx11-6\
    libxcb1\
    libxcomposite1\
    libxdamage1\
    libxext6\
    libxfixes3\
    libxrandr2\
    freeglut3-dev\
    xvfb\
    x11-utils\
    unzip
RUN conda update pip -y
RUN conda install -y -c conda-forge pyimagej=1.3.2 openjdk=8
RUN wget https://downloads.imagej.net/fiji/archive/20201104-1356/fiji-linux64.zip && \
    unzip fiji-linux64.zip -d /home && \
    # fix FilamentDetector issue
    mv /home/Fiji.app/jars/FilamentDetector-1.0.0.jar /home/Fiji.app/jars/FilamentDetector-1.0.0.jar.disabled && \
    /home/Fiji.app/ImageJ-linux64 --update add-update-site DeepImageJ https://sites.imagej.net/DeepImageJ
ADD run_imagej_service.py /home
ADD requirements.txt /home
RUN pip install --no-cache-dir -r requirements.txt
ADD waitForX.sh /home
RUN chmod +x /home/waitForX.sh