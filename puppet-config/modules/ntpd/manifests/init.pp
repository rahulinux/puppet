class ntpd {

        package { "ntp": ensure => present }

        file { "/etc/ntp.conf" :
                owner => root,
                group => root,
                mode => 444,
                backup => false,
                source => "puppet:///modules/ntpd/etc/ntp.conf",
                require => Package["ntp"],
        }

        service { "ntpd":
                enable => true,
                ensure => running,
                subscribe => [ Package[ntp], File["/etc/ntp.conf"], ],
        }

}
