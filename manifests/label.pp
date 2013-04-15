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
    'UNSET'   => '02',
    default   => $order,
  }

  concat_fragment { "${name}+${order_real}.edac.labels.db":
    content => $content,
  }

}
