# == Class: php::apt
#
# Configure dotdeb package repository
#
# === Parameters
#
# No parameters
#
# === Variables
#
# No variables
#
# === Examples
#
#  include php::apt
#
# === Authors
#
# Christian "Jippi" Winther <jippignu@gmail.com>
#
# === Copyright
#
# Copyright 2012-2015 Christian "Jippi" Winther, unless otherwise noted.
#
class php::apt(
  $location     = 'http://packages.dotdeb.org',
  $release      = 'wheezy-php55',
  $repos        = 'all',
  $include_src  = false,
  $dotdeb       = true
) {

  apt::source { "source_php_${release}":
    location    => $location,
    release     => $release,
    repos       => $repos,
    include_src => $include_src
  }

  if ($dotdeb) {
    # wheezy-php55 requires both repositories to work correctly
    # See: http://www.dotdeb.org/instructions/
    if $release == 'wheezy-php55' {
      apt::source { 'dotdeb-wheezy':
        location    => $location,
        release     => 'wheezy',
        repos       => $repos,
        include_src => $include_src
      }
    }

    apt::key { 'add_dotdeb_key':
      key => '6572BBEF1B5FF28B28B706837E3F070089DF5277',
    }

    Apt::Key['add_dotdeb_key'] -> Apt::Source["source_php_${release}"]
  }
}
