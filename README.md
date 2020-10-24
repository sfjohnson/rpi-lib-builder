# Raspberry Pi Library Builder
Container to build libraries for Raspberry Pi.

## Usage
```
BUILD_SCRIPT=<script> docker-compose up --build
```

Where `<script>` is the script within the code folder to run e.g. `build-graphics-drm.sh`.

## Scripts

`build-graphics-drm.sh`: Builds Mesa 3D and SDL2 for KMSDRM, without X11 or Wayland. Outputs `.tcz` files for piCore http://tinycorelinux.net/11.x/armv6/releases/RPi/README.
