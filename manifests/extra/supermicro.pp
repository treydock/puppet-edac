# == Class: edac::extra::supermicro
#
# Adds non-standard DIMM labels for Supermicro motherboards
#
# === Authors
#
# Trey Dockendorf <treydock@gmail.com>
#
# === Copyright
#
# Copyright 2013 Trey Dockendorf
#
class edac::extra::supermicro {

  edac::label { 'edac::extra::supermicro':
    source => 'puppet:///modules/edac/supermicro.db',
    order  => '2',
  }

}
