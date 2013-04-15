# == Class: edac::extra
#
# Adds all non-standard DIMM labels.
#
# === Examples
#
#  class { 'edac::extra': }
#
# === Authors
#
# Trey Dockendorf <treydock@gmail.com>
#
# === Copyright
#
# Copyright 2013 Trey Dockendorf
#
class edac::extra {

  include edac::extra::supermicro

}
