Exec {
  path => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
}

class { 'oxid':
  db_user       => $db_username,
  db_password   => $db_password,
}

class { 'phpmyadmin': 
  installpath => '/var/www/phpmyadmin',
  dbuser => $db_username,
  dbpass => $db_password,
  dbname => 'oxid',  
}

exec { "add_vagrant_to_wwwdata":
  command => "sudo adduser vagrant www-data",
}

exec { "chown_docroot":
  command => "sudo chown -R www-data:www-data /var/www/",
  require  => Class['oxid'],
}

oxid::apache { 'apache.oxid':
  port     => 80,
  docroot  => '/var/www',
  priority => '10',
  require  => Class['oxid'],
}

exec { "restart_apache_after_vagrant_shares":
  command => "sudo apache2ctl restart",
  require  => Class['oxid'],
}

exec { "redirect_8080_to_80_locally":
  command => "sudo iptables -t nat -F && iptables -t nat -A OUTPUT -d localhost -p tcp --dport 8080 -j REDIRECT --to-port 80",
  require  => Class['oxid'],
}

package {'g++':
    ensure   => present,
    provider => apt,
}

include nodejs

# This doesn't work yet because puppet tries to run it before installing g++ via apt;
# Install it manually by running:
# npm install zombie --global
#package { 'zombie':
#  ensure => "1.4.1",
#  provider => 'npm',
#}