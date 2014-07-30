# = Class: oxid::php
# 
# This class installs PHP including all modules required by OXID.
# Lots of useful PHP QA packages and Composer will be installed as well.
# 
# == Parameters: 
# 
# == Requires: 
# 
# == Sample Usage:
#
#  include oxid::php
#
class oxid::php(
  $proxy = $oxid::params::proxy,
) {

  include php

  php::module { ['snmp', 'curl', 'xdebug', 'mysql', 'gd', 'sqlite', 'memcache', 'mcrypt', 'imagick', 'geoip', 'uuid', 'recode', 'cgi', 'ldap']: 
    require => Class["php::install", "php::config"],
  }

  php::conf { [ 'pdo' ]:
    source  => 'puppet:///modules/oxid/etc/php5/conf.d/',
    require => Class["php::install", "php::config"],
  }
  php::conf { [ 'pdo_mysql' ]:
    source  => 'puppet:///modules/oxid/etc/php5/conf.d/',
    require => Class["php::install", "php::config"],
  }
  php::conf { [ 'mysqli' ]:
    source  => 'puppet:///modules/oxid/etc/php5/conf.d/',
    require => Class["php::install", "php::config"],
  }
  php::conf { [ 'zendguard_loader' ]:
    source  => 'puppet:///modules/oxid/etc/php5/conf.d/',
    require => Class["php::install", "php::config"],
  }
  
  class { 'pear': 
    require => Class['php::install'],
#	notify  => Exec['set_pear_proxy'],
  }
  
#  exec { 'set_pear_proxy' :
#	command => "pear config-set http_proxy $proxy",
#  }
  
  pear::package { 'PHPUnit':
    repository => 'pear.phpunit.de',
	require    => Class["pear"],
  }

#  pear::package { "PHPUnit_MockObject":
#    repository => "pear.phpunit.de",
#    require    => Pear::Package["PEAR"],
#  }

#  pear::package { "PHP_CodeCoverage":
#    repository => "pear.phpunit.de",
#    require    => Pear::Package["PEAR"],
#  }

#  pear::package { "PHPUnit_Selenium":
#    repository => "pear.phpunit.de",
#    require    => Pear::Package["PEAR"],
#  }

  exec { 'install_composer':
    command => 'curl -s https://getcomposer.org/installer | php -- --install-dir="/bin"',
    require => [ Package['curl'], Class["php::install", "php::config"] ],
    unless  => 'which composer.phar',
  }

  # TODO add channels... we should fork pear module and send pull requests
  # pear module should allow to add channels, do upgrade and install a
  # package only if not already installed
  # pear upgrade pear
  # pear channel-discover pear.phpunit.de
  # pear channel-discover pear.symfony-project.com
  # pear channel-discover components.ez.no
  # pear update-channels
  # pear upgrade-all
  # pear install --alldeps phpunit/PHPUnit

}
