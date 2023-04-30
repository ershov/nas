#!/bin/bash

set -uxeo pipefail

apt update -y
DEBIAN_FRONTEND=noninteractive apt install -y \
    nethogs iftop iptraf-ng sysstat \
    samba \
    less \
    tig exuberant-ctags \
    locate \
    ascii \
    exfatprogs \
    ffmpeg \
    youtube-dl \
    #

cat >> /etc/samba/smb.conf << '_E'

[data]
    comment = Data
    path = /mnt/data
    read only = yes
    browsable = yes
    guest ok = no
    security = user

[incoming]
    comment = Incoming
    path = /mnt/data/incoming
    read only = no
    browsable = yes
    guest ok = yes

[photo_upload]
    comment = Photos Upload
    path = /mnt/data/photo_upload
    read only = no
    browsable = yes
    guest ok = no
    security = user

_E
service smbd restart

cat > /etc/udev/rules.d/80-usbdev.rules << '_E'
# /etc/udev/rules.d/80-usbdev.rules
# https://community.openhab.org/t/how-to-make-symlinks-for-usb-ports-in-linux-extra-java-opts/89615
# https://help.ubuntu.com/community/AutomaticallyMountPartitions
# https://stackoverflow.com/questions/19174482/udev-rule-with-binterfacenumber-doesnt-work
# sudo udevadm control --reload
# sudo udevadm test /dev/block/8:32
# sudo udevadm trigger --type=devices --action=add
#
# https://andreafortuna.org/2019/06/26/automount-usb-devices-on-linux-using-udev-and-systemd/
# https://www.axllent.org/docs/auto-mounting-usb-storage/
# https://gist.github.com/juancarlospaco/7f4eab1b6899c55ea90dc0ef5eea965d

#ENV{ID_PATH}=="*usb*", SYMLINK+="usb"
ENV{ID_PATH}=="*usb*", ENV{DEVTYPE}=="disk", SYMLINK+="usbstorage"
ENV{ID_PATH}=="*usb*", ENV{DEVTYPE}=="disk", ATTRS{bInterfaceNumber}=="?*", SYMLINK+="usbstorage$attr{bInterfaceNumber}"
_E
udevadm control -R

# lsusb -v |less
# udevadm test /dev/block/8:32
# /usr/lib/udev/rules.d/...
# udisksctl mount -b /dev/sdc1

# /etc/crontab:
# */5 *   * * *   ershov  /usr/bin/flock -n /home/ershov/nas/phcp-cron-nas.sh /home/ershov/nas/phcp-cron-nas.sh
