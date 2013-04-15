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

  case $::osfamily {
    'RedHat': {
      $edac_utils_package_name    = 'edac-utils'
      $edac_service_name          = 'edac'
      $edac_service_hasstatus     = true
      $edac_service_hasrestart    = true
      $labelsdb_file              = '/etc/edac/labels.db'
    }

    default: {
      fail("Unsupported osfamily: ${::osfamily}, module ${module_name} only supports osfamily RedHat")
    }
  }

}
