#!/bin/bash
#####################################
# Extract root file system          #
# from update image                 #
#####################################

ROOTFS=root.jffs2
URL='http://edgedownloads.elgato.com/eyetvdownloads/support/Firmware/EyeTV_Netstream/eyetv_netstream_112_311_update.zip'
ZIP='eyetv_netstream_112_311_update.zip'
FIRMWARE='eyetv-netstream-1.1.2.update'
wget $URL
unzip $ZIP

mkdir regular
mv __MACOSX/eyetv-netstream-1.1.2.update regular/
rmdir "__MACOSX"


cd regular
#hexdump -C -n 2048 eyetv-netstream-1.1.2.update

head -c 1024 $FIRMWARE > magic 
head -c 2048 $FIRMWARE | tail -c +1025 > check 
# extract firmare file
tail -c +2049 $FIRMWARE > root.jffs2

# get the root.jffs2 size
SIZE=`ls -l --block-size=1K root.jffs2|awk '{print $5}'`
echo $SIZE

# Create mtdblock
sudo modprobe mtdram total_size=$SIZE

# Load modules
sudo modprobe jffs2
sudo modprobe block2mtd
sudo modprobe mtdblock

# Copy image to mtdblock
#dd if=./root.jffs2 of=/dev/mtdblock1
sudo dd if=./root.jffs2 of=/dev/mtdblock0

# Check mtdblocks
cat /proc/mtd

# Mount jffs2 partition
mkdir extract

mkdir /tmp/mountpoint
sudo mount -t jffs2 /dev/mtdblock0 /tmp/mountpoint

# Unload modules
sudo rmmod block2mtd
sudo rmmod jffs2
sudo rmmod mtdblock

# Extract webinterface
cp -r extract/resources/ .
cp -r extract/www/resource/ .
cp -r extract/www/script .

