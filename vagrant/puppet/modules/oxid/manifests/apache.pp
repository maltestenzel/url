# = Definition: oxid::apache
#
# This definition installs Apache2 including some modules like
# mod_rewrite and creates a virtual host.
#
# == Parameters: 
#
# $name::      The name of the host
# $port::      The port to configure the host
# $priority::  The priority of the site
# $docroot::   The location of the files for this host
#
# == Actions:
#
# == Requires: 
#
# The oxid class
#
# == Sample Usage:
#
#  oxid::apache { 'apache.oxid': }
#
#  oxid::apache { 'apache.oxid':
#    port     => 80,
#    priority => '10',
#    docroot  => '/var/www/oxid',
#  }
#
define oxid::apache (
  $port     = '80',
  $docroot  = $oxid::params::apachedocroot,
  $priority = '10'
) {  

  host { "${name}":
    ip => "127.0.0.1";
  } 

  include apache

  include apache::mod::php
  include apache::mod::auth_basic
  # TODO move this to a class and include it. This allows us to define multiple apache hosts
  apache::mod {'vhost_alias': }
  apache::mod { 'rewrite': }

  apache::vhost { "${name}":
    priority   => $priority,
    vhost_name => '_default_',
    port       => $port,
    docroot    => $docroot,
    override   => 'all',
    require    => [ Host[$name], Class['oxid::php'] ],
    configure_firewall => true,
  }

}
