# = Class: oxid::params
# 
# This class manages OXID parameters
# 
# == Parameters: 
# 
# == Requires: 
# 
# == Sample Usage:
#
# This class file is not called directly
#
class oxid::params {
  $user    = 'www-data'
  $group   = 'www-data'
  $docroot = '/var/www/oxid'
  $apachedocroot = '/var/www/oxid/eshop'

  $db_user     = 'oxid'
  $db_password = 'oxid'
  
  $proxy = ''
}
