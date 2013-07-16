# == Define: edac::label
#
# Allow adding additional DIMM labels to the EDAC labels.db file
#
# === Parameters
#
# [*content*]
#   The content to be added to labels.db
# [*order*]
#   The order to be set in concat_fragment resource.
#   Sets the order that the content appears in the file resource.
#   Default: 99
#
# === Examples
#
#  edac::label { 'H8DGU':
#    content => template('supermicro/h8dgu.erb'),
#  }
#
# === Authors
#
# Trey Dockendorf <treydock@gmail.com>
#
# === Copyright
#
# Copyright 2013 Trey Dockendorf
#
define edac::label ($content, $order = 'UNSET') {

  include edac

  $order_real = $order ? {
    'UNSET'   => '99',
    default   => $order,
  }

  concat_fragment { "edac.labels.db+${order_real}_${name}":
    content => $content,
    notify  => Service['edac'],
  }

}
