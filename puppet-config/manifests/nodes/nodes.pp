#=======================================================
# common and Base packages and required settings
# following default will apply to all nodes
# because it has inherited 

node default {
      include base
      include motd
      include ntpd
      include resolv_conf
      include ssh
      include sudo
}


#=======================================================
# define each node 

node 'ldap.home.local' inherits default {

	include apache
	file {"index.html":
		path => "/var/www/html/index.html",
		ensure => file,
		source => "puppet:///modules/apache/ldap-index.html",
	}

	apache::vhost { 'ldap.home.local' :
	
		port => '80',
		docroot => '/var/www/html/',

	}



}


node 'nagios.home.local' inherits default {

	package { "epel-release":
		ensure => present,
		source => "https://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm",
		provider => rpm,

	}

	class { 'nagios::server':
	  apache_httpd_ssl             => false,
	  apache_httpd_conf_content    => template('nagios/apache_httpd/httpd-nagios.conf.erb'),
	  apache_httpd_htpasswd_source => 'puppet:///modules/nagios/htpasswd',
	  cgi_authorized_for_system_information        => '*',
	  cgi_authorized_for_configuration_information => '*',
	  cgi_authorized_for_system_commands           => '*',
	  cgi_authorized_for_all_services              => '*',
	  cgi_authorized_for_all_hosts                 => '*',
	  cgi_authorized_for_all_service_commands      => '*',
	  cgi_authorized_for_all_host_commands         => '*',
	  cgi_default_statusmap_layout                 => '3',
	}	

	class { 'nagios::client':
	 	  nrpe_allowed_hosts => '127.0.0.1, 10.0.0.3',
		  # You will need to use the type "nagios_hostgroup" on the server for
		  # all of the possible domain values to create the hostgroups.
		  host_hostgroups => $::domain,
		
	}

}

