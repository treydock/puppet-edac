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
  $edac_service_hasstatus     = $edac::params::edac_service_hasstatus,
  $edac_service_hasrestart    = $edac::params::edac_service_hasrestart,
  $edac_service_status        = $edac::params::edac_service_status,
  $labelsdb_file              = $edac::params::labelsdb_file,
  $with_extra_labels          = $edac::params::with_extra_labels
) inherits edac::params {

  validate_bool($edac_service_enable, $with_extra_labels)

  if $with_extra_labels {
    include edac::extra
  }

  if $edac_service_enable {
    $service_ensure = 'running'
    $service_enable = true
  } else {
    $service_ensure = 'stopped'
    $service_enable = false
  }

  package { 'edac-utils':
    ensure => 'present',
    name   => $edac_utils_package_name,
  }

  service { 'edac':
    ensure     => $service_ensure,
    name       => $edac_service_name,
    enable     => $service_enable,
    hasstatus  => $edac_service_hasstatus,
    hasrestart => $edac_service_hasrestart,
    status     => $edac_service_status,
    require    => Package['edac-utils'],
  }

  concat_build { 'edac.labels':
    order   => ['*.db'],
    require => Package['edac-utils'],
    notify  => [Service['edac'],File[$labelsdb_file]],
  }

  file { $labelsdb_file:
    ensure  => present,
    source  => concat_output('edac.labels'),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => [Package['edac-utils'],Concat_build['edac.labels']],
  }

  concat_fragment { 'edac.labels+01_main.db':
    content => template('edac/labels.db.erb'),
  }

}
