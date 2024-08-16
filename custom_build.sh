#!/usr/bin/env sh



# sudo git clean -fdx .

# HYPERVISORS="qemu cloud-hypervisor"
HYPERVISORS="cloud-hypervisor"
for i in $HYPERVISORS virtiofsd kernel rootfs-image shim-v2; do rustup run 1.75.0 make USE_CACHE=no $i-tarball || (echo "$i-tarball failed" && exit 1); done
mkdir kata-artifacts
for i in $HYPERVISORS virtiofsd kernel rootfs-image shim-v2; do cp build/kata-static-$i.tar.xz kata-artifacts/ ; done
./tools/packaging/kata-deploy/local-build/kata-deploy-merge-builds.sh kata-artifacts versions.yaml
./tools/packaging/kata-deploy/local-build/kata-deploy-build-and-upload-payload.sh $(pwd)/kata-static.tar.xz docker.io/codedown/kata-deploy 3.7.0-with-bin-fix-5
