#Gentoo-EC2

####Modifications made to suit my requirements for building Gentoo server AMIs on Amazon EC2

[Improved by rich0 on GitHub](http://github.com/rich0)
 
[Origin edowd on BitBucket](https://bitbucket.org/edowd)

#####Tool Requirements - Amazon EC2 API Tools - Java 6 current update 

* [Download latest version Amazon EC2 API Tools](http://docs.amazonwebservices.com/AWSEC2/latest/UserGuide/SettingUp_CommandLine.html)

* [Setup Amazon EC2 API Tools](http://docs.amazonwebservices.com/AWSEC2/latest/UserGuide/SettingUp_CommandLine.html)

* [AWS Console Login Link](http://aws.amazon.com/console/)

* Login AWS Console -> Go To -> Drop Down You User Account Name Upper Right Hand Corner AWS Console -> Security Credentials -> \
Access Credentials -> X.509 Certificates -> Create New Certificate -> Download Private Key File -> Download X.509 Certificate 

* Place your X.509 certificate and Private Key in a folder $PATH 

* Add the following environment variables to your $SHELL $PATH
```
export JAVA_HOME=/usr
export EC2_HOME="/home/alienone/aws-tools"
export PATH=$PATH:$EC2_HOME/bin
export EC2_CERT="/home/alienone/Downloads/YOUR_AMAZON_x509-CERTIFICATE_FILE_NAME"
export EC2_PRIVATE_KEY="/home/alienone/Downloads/YOUR_AMAZON_x509_KEY_FILE_NAME"
```
* Reset your Bash $SHELL environment variable from a terminal/console 
```
. .bashrc
```

```
setup_build_gentoo.sh
```

####Sets up common needs for 32 and 64 bootstrap scripts and will print out the 

#####4 options, in order:

* region

* security group

* key pair

* private key of key pair

#####If value parameters are not provided at command line

* region defaults to "us-east-1"

* security group defaults to "gentoo-bootstrap" and it will be created if needed

* key pair defaults to "gentoo-bootstrap_$region" e.g. gentoo-bootstrap_us-east-1

* key file defaults to "gentoo-bootstrap_$region.pem"

* The key pair will be created if needed.


```
build_gentoo_64.sh
```

#####Builds 64 bit Gentoo image. Will use a c1.xlarge for bootstrap instance.

* Will use a t1.micro as test instance.

* Because sudo will be called, this script cannot be run in the backgroud.

* Recommend running screen before running.

#####4 options, in order:

* region 

* security group

* key pair

* keyfile


```
build_gentoo_32.sh
```

#####Builds 32 bit Gentoo image. Will use a c1.medium for bootstrap instance.

* Will use a t1.micro as test instance.

* Because sudo will be called, this script cannot be run in the backgroud.

* Recommend running screen before running.

#####4 options, in order:

* region 

* security group

* key pair

* keyfile


```
x86_64/remote_gentoo.sh
i386/remote_gentoo.sh
```
#####The script to be copied to and executed on bootstrap instance.

```
x86_64/.config
i386/.config
```
#####The .config file for building the Linux kernel.


