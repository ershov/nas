#!/bin/bash

die() { echo "$@"; exit 1; }

U="$1"
id -u "$U" || die "Please supply your main non-root user on the command line."
[ -f ./install.sh ] || die "Please run the script from its directory."

set -uxeo pipefail

### Set console font size

perl -npi -E '/FONTSIZE=/ and $_=qq{FONTSIZE="8x14zz"\n}' /etc/default/console-setup
setupcon

### Install packages

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

### Seed user's home

USERHOME="$(bash -c "echo ~$U")"
-d "$USERHOME" || exit 1
[[ "$USERHOME" != "$HOME" ]] && cp -a home/.[a-z]* "$USERHOME"

### Mount points

mkdir -p /mnt/data
mkdir -p /mnt/zoom

### Set up Samba

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
    #guest ok = yes
    guest ok = no
    security = user

[photo_upload]
    comment = Photos Upload
    path = /mnt/data/photo_upload
    read only = no
    browsable = yes
    guest ok = no
    security = user

_E
service smbd restart

### Add an alias for usb drives.

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

### Allow user to mount the flash drive:

#mkdir -p /mnt/zoom
#cat >> /etc/fstab << '_E'
#/dev/sdd1 /mnt/zoom/ vfat ro,user,noauto 0 1
#_E

### Copy scripts

cp -a bin/* /usr/local/bin/

### Set up touch screen (if present)

if lsusb |& fgrep -q USB3IIC_CTP_CONTROL; then
    cp sbin/touchscreen_track_USB2IIC_CTP_CONTROL.sh /usr/local/bin/
    chown 0:0 sbin/touchscreen_track_USB2IIC_CTP_CONTROL.sh
    cat > /etc/sudoers.d/touch << "_E"
# Allow do dump touch events on the console

User_Alias TOUCH_USERS = $U

TOUCH_USERS ALL = NOPASSWD: /usr/local/bin/touchscreen_track_USB2IIC_CTP_CONTROL.sh

_E
fi


### Set up crontab actions

cat > /etc/cron.d/clean_macos_files << "_E"
SHELL=/bin/sh
*/5 *   * * *   root    test -d /mnt/data/incoming && find /mnt/data/incoming -name ._\* -delete
_E
cat > /etc/cron.d/phcp << "_E"
SHELL=/bin/sh
*/5 *   * * *   $U  /usr/bin/flock -n /usr/local/bin/phcp-cron-nas.sh /usr/local/bin/phcp-cron-nas.sh
_E

