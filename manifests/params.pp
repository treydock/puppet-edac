# == Class: edac::params
#
# The EDAC configuration settings.
#
# === Parameters
#
# === Variables
#
# === Authors
#
# Trey Dockendorf <treydock@gmail.com>
#
# === Copyright
#
# Copyright 2013 Trey Dockendorf
#
class edac::params {

  $with_extra_labels              = true

  case $::osfamily {
    'RedHat': {
      $edac_utils_package_name    = 'edac-utils'
      $edac_service_name          = 'edac'
      $edac_service_hasstatus     = true
      $edac_service_hasrestart    = true
      $edac_service_status        = 'edac-ctl --status --quiet'
      $labelsdb_file              = '/etc/edac/labels.db'
    }

    default: {
      fail("Unsupported osfamily: ${::osfamily}, module ${module_name} only supports osfamily RedHat")
    }
  }

}
