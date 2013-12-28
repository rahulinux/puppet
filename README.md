Puppet
======

First take look at basic question and understand the concept

# What is puppet ?

Puppet is IT automation software that helps system administrators 
manage infrastructure throughout its lifecycle, from provisioning 
and configuration to orchestration and reporting. Using Puppet, 
you can easily automate repetitive tasks, quickly deploy critical 
applications, and proactively manage change, scaling from 10s of 
servers to 1000s, on-premise or in the cloud

# The Setup

This Howtos assumes you have following things :
 - OS	 : CentOS 6.5 64 bit minimal installation 
 - IP	 : 10.0.0.11
 - Hostname : puppet.home.local
 - Disable SELinux
 - Disable IPtables for temparary later you can port tcp 443, 8140, 61613
 - Puppet Server atleast have 1 GB RAM

## Installtion 
Download Package from below link, it's around 241 MB 
http://info.puppetlabs.com/download-pe.html 
I have Downloaded :: puppet-enterprise-3.1.1-el-6-x86_64.tar.gz

Before start installation please make sure you are able to ping puppet 
So configure `/etc/hosts` file

`10.0.0.11	puppet.home.local	puppet`

# Now start installation 

 * NOTE: All commands here are run as 'root' user. You do not need to be root 
for all commands (which is recommended) but for simplicity sake root will 
be used here to eliminate confusion.

````
tar -xzvf puppet-enterprise-3.1.1-el-6-x86_64.tar.gz
cd puppet-enterprise-3.1.1-el-6-x86_64
````

Now run installer, it will ask you some questions
after installing you can access puppet via web interface 

`./puppet-enterprise-installer`





