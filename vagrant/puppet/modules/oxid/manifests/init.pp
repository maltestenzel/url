# = Class: oxid
# 
# This class installs all required packages and services in order to run OXID. 
# 
# == Parameters: 
#
# $db_user::           If defined, it creates a MySQL user with this username.
# $db_password::       The MySQL user's password.
# $db_root_password::  A password for the MySQL root user.
# $log_analytics::     Whether log analytics will be used. Defaults to true. 
#                      Valid values: true or false
# 
# == Requires: 
# 
# See README
# 
# == Sample Usage:
#
#  class {'oxid': }
#
#  class {'oxid':
#    db_root_password => '123456',
#  }
#
class oxid(
  $db_user     = $oxid::params::db_user,
  $db_password = $oxid::params::db_password,
  $db_root_password = $oxid::params::db_password,
  $proxy = $oxid::params::proxy,
  $log_analytics    = true,
) inherits oxid::params {

  include oxid::base

  # mysql / db
  class { 'oxid::db':
    username      => $db_user,
    password      => $db_password,
    root_password => $db_root_password,
    require       => Class['oxid::base'],
  }

  class { 'oxid::php':
    proxy   => $proxy,
    require => Class['oxid::db'],
  }

  class { 'oxid::user': }
}

