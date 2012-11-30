Gentoo-EC2
==========

Cloned From rich0 - origin from edowd - https://bitbucket.org/edowd - I have made modifications per my reqsGentoo Bootstrap

--------------------------------------------------------------------------------

setup_build_gentoo.sh

Sets up common needs for 32 and 64 bootstrap scripts and will print out the 
commands to execute them:

can pass 4 options, in order:
region
security group
key pair
private key of key pair

if you do not set these:
region defaults to "us-east-1"
security group defaults to "gentoo-bootstrap" and it will be created if needed
key pair defaults to "gentoo-bootstrap_$region" e.g. gentoo-bootstrap_us-east-1
key file defaults to "gentoo-bootstrap_$region.pem"
The key pair will be created if needed.

--------------------------------------------------------------------------------

build_gentoo_64.sh

Builds 64 bit Gentoo image. Will use a c1.xlarge for bootstrap instance.
Will use a t1.micro as test instance.
Because sudo will be called, this script cannot be run in the backgroud.
Recommend running screen before running.

Takes 4 options:
region 
security group
key pair
keyfile

--------------------------------------------------------------------------------

build_gentoo_32.sh

Builds 32 bit Gentoo image. Will use a c1.medium for bootstrap instance.
Will use a t1.micro as test instance.
Because sudo will be called, this script cannot be run in the backgroud.
Recommend running screen before running.

Takes 4 options:
region 
security group
key pair
keyfile

--------------------------------------------------------------------------------

x86_64/remote_gentoo.sh & i386/remote_gentoo.sh

The script to be copied to and executed on bootstrap instance.

--------------------------------------------------------------------------------

x86_64/.config & i386/.config

The .config file for building the kernel.

--------------------------------------------------------------------------------
