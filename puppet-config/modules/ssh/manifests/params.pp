class ssh::params {

	case $operatingsystem {

		Solaris: {
		
			$ssh_package_name = 'openssh'
		}

		/(RedHat|CentOS|Fedora)/: {

			$ssh_package_name = 'openssh-server'
		
		}

		/(Ubuntu|Debian)/: {

			$ssh_package_name = 'openssh-server'

		}

	}

}
