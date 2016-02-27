# == Class: php::extension::mysqlnd_ms::params
#
# Defaults for the mysqlnd_ms PHP extension
#
# === Parameters
#
# No parameters
#
# === Variables
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
#   Hash defining master(s), slaves(s) and
#
# [*plugin_config_path*]
#   Path to the plugin configuration file
#
# === Examples
#
# No examples
#
# === Authors
#
# Christian "Jippi" Winther <jippignu@gmail.com>
# Goran Miskovic <schkovich@gmail.com>
#
# === Copyright
#
# Copyright 2012-2015 Christian "Jippi" Winther, unless otherwise noted.
#
class php::extension::mysqlnd_ms::params {

  $ensure   = $php::params::ensure
  $package  = 'mysqlnd_ms'
  $provider = undef
  $inifile  = "${php::params::config_root_ini}/mysqlnd_ms.ini"
  $settings = [
    'set "PHP/extension" "mysqlnd_ms.so"'
  ]
  $plugin_config = {}
  $plugin_config_path = '/etc/php5/mysqlnd_ms.json'
}
