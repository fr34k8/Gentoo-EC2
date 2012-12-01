#Gentoo Amazon EC2 Automated Build on Amazon EBS 

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

###HOWTO

* Choose an Amazon EC2 Bootstrap Geographic Build Location -> South America - United Stated - Europe - Asia{Singapore/Japan}

```
> 
date
Fri Nov 30 18:37:37 EST 2012
> 
ec2-describe-regions | awk '{ print $2 }'
eu-west-1
sa-east-1
us-east-1
ap-northeast-1
us-west-2
us-west-1
ap-southeast-1
ap-southeast-2
> 
```

* In this example we will build a Gentoo Linux Server AMI on an Amazon EC2 Bootstrap server in South East Asia Zone 1

```
date
Fri Nov 30 18:54:43 EST 2012
> 
./setup_build_gentoo.sh ap-southeast-1
Gentoo 2012-11-30T18:54:45 - 2012-11-30T18:54:45: set up group

GROUP	sg-f41b1ea6	gentoo-bootstrap	Gentoo Bootstrap
GROUP			gentoo-bootstrap		
PERMISSION		gentoo-bootstrap	ALLOWS	tcp	22	22	FROM	CIDR	0.0.0.0/0	ingress
Gentoo 2012-11-30T18:54:45 - 2012-11-30T18:55:10: group set up
Gentoo 2012-11-30T18:54:45 - 2012-11-30T18:55:10: set up key
Gentoo 2012-11-30T18:54:45 - 2012-11-30T18:55:30: key set up
./build_gentoo_64.sh ap-southeast-1 gentoo-bootstrap gentoo-bootstrap_ap-southeast-1 gentoo-bootstrap_ap-southeast-1.pem
./build_gentoo_32.sh ap-southeast-1 gentoo-bootstrap gentoo-bootstrap_ap-southeast-1 gentoo-bootstrap_ap-southeast-1.pem
> 
```

* Finally execute the bootstrap script for the architecture you wish to deploy {32/64 bit}
Note the build process can take from 20 minutes to 1 hour. This is to build an AMI image which is reusable for creating new 
Amazon EC2 instances

```
./build_gentoo_64.sh ap-southeast-1 gentoo-bootstrap gentoo-bootstrap_ap-southeast-1 gentoo-bootstrap_ap-southeast-1.pem
``` 
