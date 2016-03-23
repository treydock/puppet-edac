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
  $ensure                     = 'present',
  $edac_utils_package_name    = $edac::params::edac_utils_package_name,
  $edac_service_name          = $edac::params::edac_service_name,
  $edac_service_enable        = true,
  $labelsdb_file              = $edac::params::labelsdb_file,
  $with_extra_labels          = $edac::params::with_extra_labels
) inherits edac::params {

  validate_bool($edac_service_enable, $with_extra_labels)

  case $ensure {
    'present': {
      $package_ensure = 'present'
      $exec_subscribe = Concat['edac.labels']
    }
    'absent': {
      $package_ensure = 'absent'
      $exec_subscribe = undef
    }
    default: {
      fail("Module ${module_name}: ensure parameter must be present or absent, ${ensure} given")
    }
  }

  if $with_extra_labels and $ensure == 'present' {
    include edac::extra
  }

  package { 'edac-utils':
    ensure => $package_ensure,
    name   => $edac_utils_package_name,
  }

  if $ensure == 'present' {
    service { 'edac':
      ensure  => undef,
      enable  => $edac_service_enable,
      require => Package['edac-utils'],
    }
  }

  exec { 'edac-register-labels':
    path        => '/sbin:/bin:/usr/sbin:/usr/bin',
    command     => 'edac-ctl --register-labels --quiet',
    logoutput   => false,
    refreshonly => true,
    subscribe   => $exec_subscribe,
  }

  concat { 'edac.labels':
    ensure  => $ensure,
    path    => $labelsdb_file,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    require => Package['edac-utils'],
  }

  concat::fragment { 'edac.labels-main':
    target => 'edac.labels',
    source => 'puppet:///modules/edac/labels.db',
    order  => '1'
  }

}
