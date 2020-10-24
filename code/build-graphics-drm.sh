#!/bin/bash

wget https://archive.mesa3d.org//mesa-20.2.1.tar.xz
wget https://www.libsdl.org/release/SDL2-2.0.12.tar.gz

rm -rf /home/*
tar xf mesa-20.2.1.tar.xz -C /home
tar zxf SDL2-2.0.12.tar.gz -C /home

mkdir /home/install-mesa
mkdir /home/install-sdl2
mkdir /home/SDL2-2.0.12/build
mkdir /home/mesa-20.2.1/build

cd /home/mesa-20.2.1
meson --prefix=/usr/local --libdir=/usr/local/lib --buildtype=release -Dplatforms=drm -Dglx=disabled -Dglvnd=false -Dllvm=disabled -Ddri-drivers='' -Dvulkan-drivers='' -Dgallium-drivers=vc4 build/
ninja -C build/
DESTDIR=/home/install-mesa ninja -C build/ install
# Also install mesa into container so that SDL2 can detect it
ninja -C build/ install
cd /home
mksquashfs install-mesa/ mesa-drm.tcz
md5sum mesa-drm.tcz > mesa-drm.tcz.md5.txt

cd /home/SDL2-2.0.12/build
CFLAGS="-O3 -DEGL_NO_X11" CXXFLAGS="-O3 -DEGL_NO_X11" ../configure --prefix=/usr/local --enable-video-kmsdrm --disable-video-x11 --disable-diskaudio --disable-oss --disable-pulseaudio --disable-dummyaudio --disable-video-dummy --enable-video-opengles --disable-video-opengl --enable-libudev --disable-dbus --disable-ime --disable-video-vulkan
make -j$(grep -c ^processor /proc/cpuinfo)
make DESTDIR=/home/install-sdl2 install
cd /home
mksquashfs install-sdl2/ sdl2-drm.tcz
md5sum sdl2-drm.tcz > sdl2-drm.tcz.md5.txt
