# = Class: oxid::db
# 
# This class installs several database packages which are required by OXID.
# It installs a MySQL server, starts the MySQL service and installs some 
# useful tools like Percona Toolkit and MySQLTuner.
# 
# == Parameters: 
# 
# $root_password::  A password for the MySQL root user
# $username::       If defined, a MySQL user with this name will be created 
# $password::       The MySQL user's password
# 
# == Requires: 
# 
# == Sample Usage:
#
#  include oxid::db
#
#  class {'oxid::db':
#    root_password => '123456',
#    username => 'oxid',
#    password => 'oxid',
#  }
#
class oxid::db(
  $username      = $oxid::params::db_user,
  $password      = $oxid::params::db_password,
  $root_password = $oxid::params::db_password
) {

  class { 'mysql': }

  class { 'mysql::server':
    config_hash => { 'root_password' => $root_password, 'bind_address'  => '0.0.0.0', }
  }

  # pre-create a database
  database { 'oxid':
    ensure   => present,
    charset  => 'utf8',
    provider => 'mysql',
    require  => Class['mysql::server'],
  }

  database { 'oxid-jenkins':
    ensure   => present,
    charset  => 'latin1',
    provider => 'mysql',
    require  => Class['mysql::server'],
  }
  
  database_user { "$username@localhost":
    ensure        => present,
    password_hash => mysql_password($password),
    provider      => 'mysql',
    require       => Class['mysql::server'],
  }

  database_user { "$username@10.0.2.2":
    ensure        => present,
    password_hash => mysql_password($password),
    provider      => 'mysql',
    require       => Class['mysql::server'],
  }

  database_grant { "$username@localhost":
    privileges => ['all'],
    provider   => 'mysql',
    require    => Database_user["$username@localhost"],
  }

  database_grant { "$username@10.0.2.2":
    privileges => ['all'],
    provider   => 'mysql',
    require    => Database_user["$username@10.0.2.2"],
  }

  include mysql::server::mysqltuner

  package { "percona-toolkit": ensure => installed }

}
