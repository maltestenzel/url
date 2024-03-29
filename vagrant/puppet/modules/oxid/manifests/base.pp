# = Class: oxid::base
# 
# This class installes some base packages like git, subversion, vim
# and more.
# 
# == Parameters: 
# 
# == Requires: 
# 
# == Sample Usage:
#
#  include oxid::base
#
class oxid::base {

  include apt

  notify {"apt-get_update": }

  exec { "base_apt-get_update": command => "apt-get update" }

  package { 'vim': ensure => installed, require => Exec['base_apt-get_update'] }

  package { 'facter': ensure => latest, require => Exec['base_apt-get_update'] }

  package { 'strace': ensure => latest, require => Exec['base_apt-get_update'] }

  package { 'tcpdump': ensure => latest, require => Exec['base_apt-get_update'] }

  package { 'wget': ensure => latest, require => Exec['base_apt-get_update'] }

  package { 'curl': ensure => latest, require => Exec['base_apt-get_update'] }
  
  package { 'ansible': ensure => latest, require => Exec['base_apt-get_update'] }
  
  package { 'subversion': ensure => latest, require => Exec['base_apt-get_update'] }
  
  package { 'sshpass': ensure => latest, require => Exec['base_apt-get_update'] }  
}
