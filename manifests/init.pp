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
#
# [*edac_service_name*]
#
# [*edac_service_hasstatus*]
#
# [*edac_service_hasrestart*]
#
# [*labelsdb_file*]
#
# [*with_extra_labels*]
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
  $edac_service_hasstatus     = $edac::params::edac_service_hasstatus,
  $edac_service_hasrestart    = $edac::params::edac_service_hasrestart,
  $labelsdb_file              = $edac::params::labelsdb_file,
  $with_extra_labels          = $edac::params::with_extra_labels

) inherits edac::params {

  if $with_extra_labels {
    include edac::extra
  }

  package { 'edac-utils':
    ensure  => 'present',
    name    => $edac_utils_package_name,
  }

  service { 'edac':
    ensure      => 'running',
    name        => $edac_service_name,
    enable      => true,
    hasstatus   => $edac_service_hasstatus,
    hasrestart  => $edac_service_hasrestart,
    require     => Package['edac-utils'],
  }

  concat_build { 'edac.labels.db':
    order   => ['*.db'],
    target  => $labelsdb_file,
    require => Package['edac-utils'],
    notify  => Service['edac'],
  }

  file { $labelsdb_file:
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => Package['edac-utils'],
  }

  concat_fragment { 'edac.labels.db+01_main.db':
    content => template('edac/labels.db.erb'),
  }

}
