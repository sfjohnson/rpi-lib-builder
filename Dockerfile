FROM balenalib/raspberry-pi:latest
RUN install_packages python3-pip python3-setuptools ninja-build wget git bison flex cmake zlib1g-dev pkg-config libdrm-dev squashfs-tools build-essential

COPY ./code /code
WORKDIR /code
RUN pip3 install -Ur requirements.txt
