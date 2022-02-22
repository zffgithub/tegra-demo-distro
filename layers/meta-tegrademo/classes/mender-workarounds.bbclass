# Work around the global export of this variable
# that is added in mender-setup.bbclass
unset MENDER_MACHINE[export]
# and the addition of the variable to the ignore
# list, which changes the signature for all tasks
BB_BASEHASH_IGNORE_VARS:remove = "MENDER_MACHINE"

DISTRO_FEATURES_BACKFILL:remove = "systemd"

BBMASK += "/meta-mender-core/recipes-devtools/e2fsprogs/"
BBMASK += "/meta-mender-core/recipes-core/systemd/"

MENDER_DATA_PART_FSTAB_OPTS ?= "defaults,data=journal"
OS_RELEASE_VERSION ??= "${BUILDNAME}"

update_version_files () {
    dest="$1"
    if [ -f $dest/${sysconfdir}/mender/artifact_info -a -n "${MENDER_ARTIFACT_NAME}" ]; then
        echo "artifact_name=${MENDER_ARTIFACT_NAME}" > $dest/${sysconfdir}/mender/artifact_info
    fi

    if [ -f $dest/${sysconfdir}/os-release ]; then
        sed --follow-symlinks -i -r -e's,^VERSION=.*,VERSION="${OS_RELEASE_VERSION}",' \
	    -e's,^VERSION_ID=.*,VERSION_ID="${BUILDNAME}",' \
	    -e's,^PRETTY_NAME=.*,PRETTY_NAME="${DISTRO_NAME} ${BUILDNAME}",' \
	    $dest/${sysconfdir}/os-release
    fi

    if [ -f $dest/${sysconfdir}/issue ]; then
        printf "%s \\%s \\l\n\n" "${DISTRO_NAME} ${BUILDNAME}" "n" >$dest/${sysconfdir}/issue
    fi

    if [ -f $dest/${sysconfdir}/issue.net ]; then
        printf "%s %%h\n\n" "${DISTRO_NAME} ${BUILDNAME}" >$dest/${sysconfdir}/issue.net
    fi
}

rootfs_version_info() {
    update_version_files ${IMAGE_ROOTFS}
}

ROOTFS_POSTPROCESS_COMMAND:append = " rootfs_version_info;"

PACKAGE_ARCH:pn-mender-client = "${MACHINE_ARCH}"
