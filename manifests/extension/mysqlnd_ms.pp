# == Class: php::extension::mysqlnd_ms
#
# Install the mysqlnd_ms PHP extension
# Mysqlnd replication and load balancing plugin
# http://php.net/manual/en/book.mysqlnd-ms.php
# === Parameters
#
# [*ensure*]
#   The version of the package to install
#   Could be "latest", "installed" or a pinned version
#   This matches "ensure" from Package
#
# [*package*]
#   The package name in your provider
#
# [*provider*]
#   The provider used to install the package
#
# [*inifile*]
#   The path to the extension ini file
#
# [*settings*]
#   Array of agues 'set' commands
#
# [*plugin_config*]
#   Hash defining master(s), slaves(s) and failover
#
# [*plugin_config_path*]
#   Path to the plugin configuration file
#
# === Variables
#
# No variables
#
# === Examples
#
#  include php::extension::mysqlnd_ms
#
# === Hiera configuration example
#
# php::extension::mysqlnd_ms::ensure: 'latest'
# php::extension::mysqlnd_ms::provider: 'pecl'
# php::extension::mysqlnd_ms::plugin_config_path: '/etc/php5/fpm/mysqlnd_ms.json'
# php::extension::mysqlnd_ms::settings:
#       - 'set .anon/#comment[1] "configuration for PHP mysqlnd_ms module"'
#       - 'set .anon/#comment[2] "priority=30"'
#       - 'set PHP/extension mysqlnd_ms.so'
#       - 'set PHP/mysqlnd_ms.enable 1'
#       - 'set PHP/mysqlnd_ms.config_file "/etc/php5/fpm/mysqlnd_ms.json"'
#       - 'set PHP/extension mysqlnd_ms.so'
# php::extension::mysqlnd_ms::plugin_config:
#     tomtest:
#         master:
#             master_0:
#                 host: "host.yourdomain.tld"
#         slave:
#             slave_0:
#                 host: "host.yourdomain.tld"
#                 port: 3307
#         failover: 'master'
#
# === Authors
#
# Christian "Jippi" Winther <jippignu@gmail.com>
# Goran Miskovic <schkovich@gmail.com>
#
# === Copyright
#
# Copyright 2012-2016 Christian "Jippi" Winther, unless otherwise noted.
#
class php::extension::mysqlnd_ms(
  $ensure             = $php::extension::mysqlnd_ms::params::ensure,
  $package            = $php::extension::mysqlnd_ms::params::package,
  $provider           = $php::extension::mysqlnd_ms::params::provider,
  $inifile            = $php::extension::mysqlnd_ms::params::inifile,
  $settings           = $php::extension::mysqlnd_ms::params::settings,
  $plugin_config      = $php::extension::mysqlnd_ms::params::plugin_config,
  $plugin_config_path = $php::extension::mysqlnd_ms::params::plugin_config_path
) inherits php::extension::mysqlnd_ms::params {

  php::extension { 'mysqlnd_ms':
    ensure   => $ensure,
    package  => $package,
    provider => $provider
  }
  ->
  php::config { 'php-extension-mysqlnd_ms':
    file   => $inifile,
    config => $settings
  }
  # TODO: add one more parameter to customize where json file is saved
  if ($ensure == 'absent') {
    file { $plugin_config_path:
      ensure => absent,
      require => Php::Config['php-extension-mysqlnd_ms'],
    }
  } else {
    file { $plugin_config_path:
      ensure  => file,
      require => Php::Config['php-extension-mysqlnd_ms'],
      content => template('php/mysqlnd_ms.erb'),
      owner   => root,
      group   => root,
      mode    => '0644',
    }
  }

}
