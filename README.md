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


# Puppet Architecture 

It's simple client server model as below :

  - Agents nodes/clients
   - Agent auto-fetch configuration information from master server every 30 minuts default
	
  - Master server 
  	- Master server is also an Agent
  	- Master server delivers configuration information to Agents nodes.
  	- Console server - Primary management WebGui, Can be same as Master server instancts, but should be seperated Cloud Provisioner - Permits quick deployment of of new instances. Ex. Vmware, Amazon Web Services

# General Information 

  - Puppet master collects Inventory from nodes (Agents) using "Mcollective" deamon 
  - Which OSfamily Supports by puppet ?
    - Redhat/CentOS,Scientific,Oracle
    - Debian and Ubuntu
    - Suse
    - Solaries
    - Windows ( Limited )
  - Evaluation Licenses support up to 10-Nodes 
  - Puppet Master Port : TCP 8140

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
cd /usr/local/src/
wget -cnd "https://pm.puppetlabs.com/cgi-bin/download.cgi?ver=latest&dist=el&arch=x86_64&rel=6"
tar -xzvf puppet-enterprise-3.1.1-el-6-x86_64.tar.gz
cd puppet-enterprise-3.1.1-el-6-x86_64
````

Now run installer, it will ask you some questions
after installing you can access puppet via web interface 

`./puppet-enterprise-installer`

# Add Client
First configure `/etc/hosts` file 

````
10.0.0.11  puppet.home.local  puppet
````

Setup Yum repo for install puppet agent 
```rpm -ivh https://yum.puppetlabs.com/el/6/products/x86_64/puppetlabs-release-6-7.noarch.rpm```

Enable repo

```sed -i 's/enabled=0/enabled=1/g' /etc/yum.repos.d/puppetlabs.repo```

Install puppet agent 

```yum install -y puppet```

Edit `/etc/puppet/puppet.conf` and add the agent variables:
````
# In the [agent] section
 
    server = puppet
    report = true
    pluginsync = true
````
Enable Puppet at startup
````
chkconfig --level 35 puppet on
puppet agent --daemonize
````

Go to your puppet server and check for signed requests from your nodes

````
# Note you will have to do this anytime a new node attempts to join the puppet master
puppet cert list
```` 
Output :

````
[root@puppet ~]# puppet cert list
  "ldap.home.local" (SHA256) F3:10:AF:50:82:7D:36:3E:4F:A6:97:0A:23:F9:F7:8C:7A:5B:BA:B2:AD:2F:8E:76:01:8A:A5:02:E8:BF:92:54
````

Sign the cert to allow the puppet node to join:
````puppet cert sign ldap.home.local````

Output :

````
Notice: Signed certificate request for ldap.home.local
Notice: Removing file Puppet::SSL::CertificateRequest ldap.home.local at '/etc/puppetlabs/puppet/ssl/ca/requests/ldap.home.local.pem
````

# Verifying Installation
To verify installation, you just need to run following command :

````
puppet agent --test
````





