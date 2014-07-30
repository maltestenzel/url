puppet-oxidce module
============

### OXID CE - Open Source E-Commerce

OXID CE is a downloadable, free/libre e-commerce software. It provides you with a fully fledged e-commerce environment based on PHP.

The work on this puppet module was heavily inspired by the [puppet-piwik](https://github.com/piwik/puppet-piwik) module. Thanks for this!

### License: 
GPL v3 or later

### Link: 
http://www.oxidforge.org/

## How to use

### Simple Example:
```
class { 'oxidce': }
oxidce::apache { 'apache.oxidce': }
```

### Full example:
```
class { 'oxidce':
  directory     => '/var/www/oxidce',
  repository    => 'svn',
  version       => 'trunk',
  db_user       => 'username',
  db_password   => 'secure',
  svn_username  => 'myusername',
  svn_password  => 'mypassword',
}

oxidce::apache { 'apache.oxidce':
  port     => 80,
  docroot  => '/var/www/oxidce',
  priority => '10',
  require  => Class['oxidce'],
}

```

### Add further OXID CE versions/hosts:
```
oxidce::repo { 'oxidce_repo_45':
  directory  => '/var/www/oxidce45',
  version    => 'tags/4.5',
  repository => 'svn',
  require    => Class['oxidce'],
}

```

Do not forget to update your local hosts file when adding servers

### Requirements
* puppetlabs-apache - https://github.com/puppetlabs/puppetlabs-apache 
* puppet-apt - https://github.com/camptocamp/puppet-apt
* puppet-augeas - https://github.com/camptocamp/puppet-augeas
* puppet-common - https://github.com/camptocamp/puppet-common
* puppetlabs-firewall - https://github.com/puppetlabs/puppetlabs-firewall
* puppetlabs-git - https://github.com/puppetlabs/puppetlabs-git
* puppetlabs-mysql - https://github.com/puppetlabs/puppetlabs-mysql
* puppetlabs-nginx - https://github.com/Mayflower/puppetlabs-nginx
* puppet-pear - https://github.com/treehouseagency/puppet-pear
* puppet-php - https://github.com/Mayflower/puppet-php
* rafaelfc-phpqatools - https://github.com/rafaelfelix/puppet-phpqatools
* puppetlabs-stdlib - https://github.com/puppetlabs/puppetlabs-stdlib
* puppet-vcsrepo - https://github.com/openstack-ci/puppet-vcsrepo 

```
git submodule add git://github.com/puppetlabs/puppetlabs-apache modules/apache
git submodule add git://github.com/camptocamp/puppet-apt modules/apt
git submodule add git://github.com/camptocamp/puppet-augeas modules/augeas
git submodule add git://github.com/camptocamp/puppet-common modules/common
git submodule add git://github.com/puppetlabs/puppetlabs-firewall modules/Firewall
git submodule add git://github.com/puppetlabs/puppetlabs-git modules/git
git submodule add git://github.com/puppetlabs/puppetlabs-mysql modules/mysql
git submodule add git://github.com/Mayflower/puppetlabs-nginx modules/nginx
git submodule add git://github.com/treehouseagency/puppet-pear modules/pear
git submodule add git://github.com/Mayflower/puppet-php modules/php
git submodule add git://github.com/rafaelfelix/puppet-phpqatools modules/phpqatools
git submodule add git://github.com/puppetlabs/puppetlabs-stdlib modules/stdlib
git submodule add git://github.com/openstack-ci/puppet-vcsrepo modules/vcsrepo
```
