#=====================================================
# Define own classes

class resolv_conf( $nameserver1="10.0.0.1", $nameserver2="8.8.8.8",$search="home.local" ) {
			  
	$str = "search $search\nnameserver $nameserver1\nnameserver $nameserver2\n"
	
	file { "/etc/resolv.conf":
	    content => "$str",
	}
}

	

class motd {

	file { "/etc/motd":

	ensure  => file,
	content => template("/etc/motd.erb"),
	}

}

class base {

	package { "vim-enhanced":

		ensure => present,
	}
	
	group { "sysadmin": 
		ensure => present,
		gid => "1001",
		
	}
	
	user { "rahul":
		ensure => present,
		managehome => true,
		password => '$6$UU35w7hd3/nyNTmP$hT0BP991zbWFjPdNh0jpHwpDahnvkxuiyPX2qoAZUr80Zuu7c7PMCAEnRhqCpFPlfNpKDauLoPGQPcH9tbn9G/',
		groups => "sysadmin"
	}

}


#=======================================================
# import all nodes from /etc/puppet/manifests/nodes/*.pp
import "nodes/*.pp"
