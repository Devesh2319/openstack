#!/bin/bash

yum update -y

yum install -y python3

pip3 install gdown

gdown   --id   1aS5WPyv7n-NdUEJsTed4KxQ3WwN6JlLA    --output    rhel-7-server-additional-20180628.iso

gdown   --id   1bXeoQp0D0So-rk1XgPXo1MeYHmXoFcSV   --output    rhel-7.5-server-updates-20180628.iso

gdown   --id   1kkBG-Oa5sRhAZHDSEaIRsrxM0GxEv3gf    --output    RHEL7OSP-13.0-20180628.2-x86_64.iso

mkdir /updates  /additional  /RHOSP

mount -o loop rhel-7.5-server-updates-20180628.iso  /updates/

mount -o loop rhel-7-server-additional-20180628.iso  /additional/

mount -o loop RHEL7OSP-13.0-20180628.2-x86_64.iso /RHOSP/

mkdir /RHOSP13

cp -rvf /updates/  /RHOSP13/

cp -rvf /additional/  /RHOSP13/

cp -rvf /RHOSP/  /RHOSP13/

yum install createrepo  -y

createrepo -v /RHOSP13/.

cat <<EOF > /etc/yum.repos.d/openstack.repo
[Openstack]
name=Openstack
baseurl=file:///RHOSP13
gpgcheck=0
EOF
yum repolist
yum install openstack-packstack -y

packstack --gen-answer-file=setup.txt

packstack  --answer-file=setup.txt
