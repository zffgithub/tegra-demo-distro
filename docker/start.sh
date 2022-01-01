#!/bin/bash

set -e
echo '>>>>>>>>>>>>> Build Start >>>>>>>>>>>>>'

branch=$1
cd shared
echo "选择分支" ${branch:=master}
DIR="tegra-demo-distro"

function build_online() {
    if [ ! -d "$DIR" ]; then
        sudo git clone https://github.com/zffgithub/tegra-demo-distro.git -b $branch --recursive $DIR
        sudo chown build:build -R tegra-demo-distro/
    fi
    cd $DIR
    sudo chmod -R 777 .git
    sudo git pull
    sudo git submodule update --init
    # sudo rm -rf build/
    # 离线编译需要删除这个recipe
    # sudo rm ./layers/meta-tegra-community/recipes-test
    # not build in root
    # sudo chmod -R 777 ../tegra-demo-distro/
    . ./setup-env --machine jetson-xavier-nx-devkit --distro tegrademo-mender
    #bitbake demo-image-full
    bitbake demo-image-base
}

function build_offline() {
    cd $DIR
    . ./setup-env --machine jetson-xavier-nx-devkit --distro tegrademo-mender
    #bitbake demo-image-full
    bitbake demo-image-base
}

if ping -q -c 1 -W 1 8.8.8.8 >/dev/null; then
  echo "IPv4 is up"
  build_online
else
  echo "IPv4 is down"
  build_offline
fi

echo '>>>>>>>>>>>>> Build Finish >>>>>>>>>>>>>'
