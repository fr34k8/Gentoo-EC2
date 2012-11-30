#!/bin/bash

group="gentoo-bootstrap"
key="gentoo-bootstrap_eu-west-1"

latest_kernel=`ec2-describe-images \
--region eu-west-1 \
--filter image-type=kernel \
--filter manifest-location=*pv-grub* \
--owner amazon \
--filter architecture=x86_64 \
| grep -v "hd00" \
| awk '{ print $3 "\t"  $2 }' \
| sed "s:.*/pv-grub-hd0[^0-9]*::" \
| sort \
| tail -n 1 \
| awk '{ print $2 }'`

boot_image=`ec2-describe-images \
--region eu-west-1 \
--owner amazon \
--filter architecture=x86_64 \
--filter image-type=machine \
--filter root-device-type=ebs \
--filter virtualization-type=paravirtual \
--filter kernel-id=$latest_kernel \
--filter manifest-location=amazon/amzn-ami-* \
| grep "^IMAGE" \
| tail -n 1 \
| awk '{ print $2 }'`

boot_image_value=`ec2-describe-images \
--region eu-west-1 \
--owner amazon \
--filter architecture=x86_64 \
--filter image-type=machine \
--filter root-device-type=ebs \
--filter virtualization-type=paravirtual \
--filter kernel-id=$latest_kernel \
--filter manifest-location=amazon/amzn-ami-* \
| grep "^IMAGE" \
| tail -n 1 \
| awk '{ print $2 }' | wc -c`

spotreq=`ec2-request-spot-instances --price .15 --region eu-west-1 $boot_image \
--group $group \
--key $key \
--instance-type c1.medium \
--block-device-mapping "/dev/sdf=:10:false" \
| grep "^SPOTINSTANCEREQUEST" \
| awk '{ print $2 }'`

if [ $boot_image_value -eq 0 ]; then 
	echo "No AMI Present"
	echo $boot_image_value
        echo $boot_image
	exit 98
else
	echo $spotreq
	exit 99
fi
