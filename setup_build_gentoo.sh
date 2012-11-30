#!/bin/bash

#-------------------------------------------------------------------------------
# setup_build_gentoo.sh
#-------------------------------------------------------------------------------
# Copyright 2012 Dowd and Associates
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#-------------------------------------------------------------------------------

outputdir=/tmp

# The region to install into
#region="us-east-1"
region=$1

# The security group to use. 22/tcp needs to be open
# Leave empty to have a group created
#group="default"
group=$2

# The ec2 key pair to use
# Leave empty to have a key created
#key="example"
key=$3

# The fully qualified path to private key of the ec2 key pair
# Leave empty to have a key created
#keyfile="$HOME/.ssh/example.pem"
keyfile=$4


building="Gentoo"
start_time=`date +%Y-%m-%dT%H:%M:%S`

if [[ $region == "" ]]; then
    region="us-east-1"
fi

if [[ $group == "" ]]; then
    echo "$building $start_time - `date +%Y-%m-%dT%H:%M:%S`: set up group"
    group="gentoo-bootstrap"
    group_exists=`ec2-describe-group --region eu-west-1 | grep 'sg-' | grep -v 'default' | awk '{print $2}'| wc -c`
    del_group=`ec2-describe-group --region eu-west-1 | grep 'sg-' | grep -v 'default' | awk '{print $2}'`

    if [ $group_exists -eq 0 ]; then
        ec2-create-group --region $region $group --description "Gentoo Bootstrap"
    else
	ec2-delete-group --region $region $del_group
	ec2-create-group --region $region $group --description "Gentoo Bootstrap"
    fi

    ec2-authorize --region $region $group -P tcp -p 22 -s 0.0.0.0/0

    echo "$building $start_time - `date +%Y-%m-%dT%H:%M:%S`: group set up"
fi

if [[ $key == "" || $keyfile == "" ]]; then
    echo "$building $start_time - `date +%Y-%m-%dT%H:%M:%S`: set up key"
    key="gentoo-bootstrap_$region"
    keyfile="gentoo-bootstrap_$region.pem"
    query_key=`ec2-describe-keypairs --region eu-west-1 | grep 'gentoo' | awk '{print $2}' | wc -c`
    get_keyname=`ec2-describe-keypairs --region eu-west-1 | grep 'gentoo' | awk '{print $2}'`
   
    if [  $query_key -eq 0 ]; then
        ec2-create-keypair --region $region $key > $keyfile
    else
	ec2-delete-keypair --region $region $get_keyname
	ec2-create-keypair --region $region $key > $keyfile
    fi

    chmod 600 $keyfile
    echo "$building $start_time - `date +%Y-%m-%dT%H:%M:%S`: key set up"
fi

echo ./build_gentoo_64.sh $region $group $key $keyfile
echo ./build_gentoo_32.sh $region $group $key $keyfile
