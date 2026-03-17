wipefs -a /dev/sdc

fdisk /dev/sdc < sdc_layout.txt

mkfs.ext4 /dev/sdc1

mkfs.ext4 /dev/sdc2

mkdir /disk1
mkdir /disk2 

mount /dev/sdc1 /disk1

mount /dev/sdc2 /disk2

cp /home/kosa/.bashrc /disk1/aaa
 
cp /home/kosa/.bashrc /disk2/aaa

ls /disk1
ls /disk2


echo '/dev/sdc1       /disk1  ext4   defaults 0 0' >> /etc/fstab
echo '/dev/sdc2       /disk2  ext4   defaults 0 0' >> /etc/fstab


