class ssh::install {

	package { $ssh::params::ssh_package_name:

		ensure => present,
	
	}

}

class ssh::config {

	file { "/etc/ssh/sshd_config":

	ensure => present,
	owner => 'root',
	group => 'root',
	mode => '0600',
	source => "puppet:///modules/ssh/sshd_config",
	require => Class["ssh::install"],
	notify => Class["ssh::service"],
	
	
	}

}

class ssh::service {
	
	service { "sshd":
		ensure => running,
		hasstatus => true,
		hasrestart => true,
		enable => true,
		require => Class["ssh::config"],
	}

}

class ssh {

	include ssh::params, ssh::install, ssh::config, ssh::service
}
