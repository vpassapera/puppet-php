# == Class: php::extension::mysqlnd_ms::params
#
# Defaults file for the tidy PHP extension
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
#   Hash with 'set' nested hash of key => value
#   set changes to agues when applied to *inifile*
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

}
