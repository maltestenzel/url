# = Class: oxid::user
# 
# Makes sure the user exists which is used by Apache and NGINX.
# 
# == Parameters: 
# 
# == Requires: 
# 
# == Sample Usage:
#
#  include oxid::user
#
class oxid::user {
    
  # user for apache / nginx
  user { "${oxid::params::user}":
    ensure  => present,
    comment => $oxid::params::user,
    shell   => '/bin/false',
  }

}
