# == Class: edac
#
# Manage the installation and configuration of EDAC driver installation
# and configuration.
#
# === Parameters
#
# Document parameters here.
#
# [*edac_utils_package_name*]
#   Package name for edac-utils
#
# [*edac_service_name*]
#   Edac service name.
#
# [*edac_service_hasstatus*]
#   Boolean that sets if the edac service has
#   the status feature
#
# [*edac_service_hasrestart*]
#   Boolean that sets if the edac service has
#   the restart feature
#
# [*labelsdb_file*]
#   Path to the labels.db file
#
# [*with_extra_labels*]
#   Boolean that sets if the bundled extra
#   labels will be included.
#   Default: true
#
# === Examples
#
#  class { edac: }
#
# === Authors
#
# Trey Dockendorf <treydock@gmail.com>
#
# === Copyright
#
# Copyright 2013 Trey Dockendorf
#
class edac (
  $edac_utils_package_name    = $edac::params::edac_utils_package_name,
  $edac_service_name          = $edac::params::edac_service_name,
  $edac_service_enable        = true,
  $labelsdb_file              = $edac::params::labelsdb_file,
  $with_extra_labels          = $edac::params::with_extra_labels
) inherits edac::params {

  validate_bool($edac_service_enable, $with_extra_labels)

  if $with_extra_labels {
    include edac::extra
  }

  package { 'edac-utils':
    ensure => 'present',
    name   => $edac_utils_package_name,
  }

  service { 'edac':
    ensure  => undef,
    enable  => $edac_service_enable,
    require => Package['edac-utils'],
  }

  exec { 'edac-register-labels':
    path        => '/sbin:/bin:/usr/sbin:/usr/bin',
    command     => 'edac-ctl --register-labels --quiet',
    logoutput   => false,
    refreshonly => true,
    subscribe   => File[$labelsdb_file],
  }

  concat_build { 'edac.labels':
    order   => ['*.db'],
    require => Package['edac-utils'],
    #notify  => File[$labelsdb_file],
  }

  file { $labelsdb_file:
    ensure  => present,
    source  => concat_output('edac.labels'),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => Concat_build['edac.labels'],
  }

  concat_fragment { 'edac.labels+01_main.db':
    content => template('edac/labels.db.erb'),
  }

}
