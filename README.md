# tegra-demo-distro

Reference/demo distribution for NVIDIA Jetson platforms
using Yocto Project tools and the meta-tegra BSP layer.

![Build status](https://builder.madison.systems/badges/tegrademo-master.svg)
####submodule manage
-------------------------
    git submodule add  -b master --name poky --force git://git.yoctoproject.org/poky repos/poky
    git submodule add  -b master --name repos/meta-openembedded --force git://git.openembedded.org/meta-openembedded repos/meta-openembedded
    git submodule add  -b master --name repos/meta-virtualization --force git://git.yoctoproject.org/meta-virtualization repos/meta-virtualization
    git submodule add  -b dunfell-with-overrides-conversion --name repos/meta-mender --force https://github.com/madisongh/meta-mender.git repos/meta-mender
    git submodule add  -b dunfell-with-overrides-conversion --name repos/meta-mender-community --force https://github.com/OE4T/meta-mender-community.git repos/meta-mender-community
    git submodule add  -b master --name repos/meta-tegra --force https://github.com/OE4T/meta-tegra.git repos/meta-tegra
    git submodule add  -b master --name repos/meta-tegra-community --force https://github.com/OE4T/meta-tegra-community repos/meta-tegra-community
    git submodule add  -b honister --name repos/meta-ros --force https://github.com/ros/meta-ros.git repos/meta-ros
    git submodule add  -b honister --name repos/meta-python2 --force https://github.com/YoeDistro/meta-python2.git repos/meta-python2
    git submodule add  -b honister --name repos/meta-k3s --force https://github.com/zffgithub/meta-k3s.git repos/meta-k3s
    cd layers/
    ln -s ../repos/meta-k3s ../layers/meta-k3s

Metadata layers are brought in as git submodules:

| Layer Repo            | Branch  | Description                                         |
| --------------------- | --------|---------------------------------------------------- |
| poky                  | master  | OE-Core from poky repo at yoctoproject.org          |
| meta-tegra            | master  | L4T BSP layer - L4T R32.6.1/JetPack 4.6             |
| meta-tegra-community  | master  | OE4T layer with additions from the community        |
| meta-openembedded     | master  | OpenEmbedded layers                                 |
| meta-virtualization   | master  | Virtualization layer for docker support             |
| meta-mender           | dunfell | For meta-mender-core layer used in tegrademo-mender |
| meta-mender-community | dunfell | For meta-mender-tegra integration layer             |


## Prerequisites

See the [Yocto Project Quick Build](https://docs.yoctoproject.org/brief-yoctoprojectqs/index.html)
documentation for information on setting up your build host.
In addition to the packages mentioned in that documentation, you
will need gcc and g++ 8 (on Ubuntu, packages `gcc-8` and `g++-8`).

For burning SDcards (for the Jetson Nano or Jetson Xavier NX developer
kits), the `bmap-tools` package is recommended.

## Setting up

1. Clone this repository:

        $ git clone https://github.com/OE4T/tegra-demo-distro.git

2. Switch to the appropriate branch, using the
   [wiki page](https://github.com/OE4T/tegra-demo-distro/wiki/Which-branch-should-I-use%3F)
   for guidance.

3. Initialize the git submodules:

        $ cd tegra-demo-distro
        $ git submodule update --init

4. Source the `setup-env` script to create a build directory,
   specifying the MACHINE you want to configure as the default
   for your builds. For example, to set up a build directory
   called `build` that is set up for the Jetson Xavier NX
   developer kit and the default `tegrademo` distro:

        $ . ./setup-env --machine jetson-xavier-nx-devkit

   You can get a complete list of available options, MACHINE
   names, and DISTRO names with

        $ . ./setup-env --help

5. Optional: Install pre-commit hook for commit autosigning using
        $ ./scripts-setup/setup-git-hooks

## Distributions

Use the `--distro` option with `setup-env` to specify a distribution for your build,
or customize the DISTRO setting in your `$BUILDDIR/conf/local.conf` to reference one
of the supported distributions.

Currently supported distributions are listed below:


| Distribution name | Description                                                   |
| ----------------- | ------------------------------------------------------------- |
| tegrademo         | Default distro used to demonstrate/test meta-tegra features   |
| tegrademo-mender  | Adds [mender](https://www.mender.io/) OTA support             |

### tegrademo-mender

The tegrademo-mender distro demonstrates [mender](https://www.mender.io/) OTA update
support with customizations on the tegrademo distribution including:

1. Dual A/B rootfs support with read-only-rootfs.
2. Integration with cboot and [tegra-boot-tools](https://github.com/OE4T/tegra-boot-tools)
 to support persistent systemd machine-id settings on read only rootfs.
3. Boot slot and rootfs partition synchronization through boot tools and bootloader
integration.

The synchronization of boot slot and root filesystem partition is more complicated to
manage and test with via u-boot (see [this issue](https://github.com/BoulderAI/meta-mender-community/pull/1#issue-516955713)
for detail).  For this reason, the tegrademo-mender distribution defaults to use the
cboot bootloader on Jetson TX2, instead of the default u-boot bootloader used by
meta-tegra.  If you need to use a different bootloader you can customize the setting
of `PREFERRED_PROVIDER_virtual/bootloader_tegra186` in your distro layer.

## Images

The `tegrademo` distro includes the following image recipes, which
are dervied from the `core-image-XXX` recipes in OE-Core but configured
for Jetson platforms. They include some additional test tools and
demo applications.

| Recipe name       | Description                                                   |
| ----------------- | ------------------------------------------------------------- |
| demo-image-base   | Basic image with no graphics                                  |
| demo-image-egl    | Base with DRM/EGL graphics, no window manager                 |
| demo-image-sato   | X11 image with Sato UI                                        |
| demo-image-weston | Wayland with Weston compositor                                |
| demo-image-full   | Sato image plus nvidia-docker, openCV, multimedia API samples |

# Contributing

Please see the contributor wiki page at [this link](https://github.com/OE4T/meta-tegra/wiki/OE4T-Contributor-Guide).
Contributions are welcome!

