# puppet-edac

[![Puppet Forge](http://img.shields.io/puppetforge/v/treydock/edac.svg)](https://forge.puppetlabs.com/treydock/edac)
[![Build Status](https://travis-ci.org/treydock/puppet-edac.svg?branch=master)](https://travis-ci.org/treydock/puppet-edac)

####Table of Contents

1. [Overview](#overview)
2. [Module Description](#module-description)
3. [Setup - The basics of getting started with puppet-edac](#setup)
  * [What puppet-edac affects](#what-puppet-edac-affects)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - Parameter and detailed reference to all options](#reference)
  * [Public classes](#public-classes)
  * [Private classes](#private-classes)
  * [Class Parameters](#class-parameters)
  * [Defined types](#defined-types)
6. [Limitations](#limitations)
7. [Contributing](#contributing)
8. [Development](#development)
9. [TODO](#TODO)
10. [Further Information](#further-information)

## Overview

This module manages installation and configuration of edac utilities for Linux kernel EDAC drivers.

## Module Description

This module will install the necessary packages to use EDAC and start the necessary service.  The labels used by EDAC are also managed and custom labels can be added by using the `edac::label` defined type.

Once this module is applied to a system the `edac-util` command can be used to query corrected and uncorrected memory errors.  If labels exist for your host's motherboard then memory DIMMs with errors can be easily identified.

## Setup

###What puppet-edac affects

* The edac-utils package is installed - the actual name may vary depending on your Operating System
* The labels database, `/etc/edac/labels.db` is populated by the default labels and any custom labels defined
* The labels are registered with edac
* The edac service is set to start on boot

## Usage

For standard edac-utils management

    class { 'edac': }

To add additional labels to labels.db

    edac::label { 'H8DGU':
      content => template('supermicro/h8dgu.erb'),
    }

The example above is provided by the `edac::extra::supermicro` class and automatically included if the parameter `with_extra_labels` is `true`.

## Reference

###Classes

####Public classes

* `edac`: Installs and configures necessary resources for EDAC
* `edac::extra`: Includes the classes that are considered "extra" and not part of stock EDAC install
* `edac::extra::supermicro`: Defines edac labels specific to Supermicro motherboards that are not a part of standard edac install

####Private classes

* `edac::params`: Defines module parameter defaults based on fact values.

###Class parameters

####edac

#####`ensure`

This determines if the managed resources are installed and configured, or if they should be removed.
Defaults to `present` and valid values are `present` and `absent`.

#####`edac_utils_package_name`

edac utils package.  Default is OS specific.

#####`edac_service_name`

edac service name.  Default is OS specific.

#####`edac_service_enable`

Sets the edac service enable property.  Default is `true`.

#####`labelsdb_file`

Location of the edac labels database file.  Default is OS specific.

#####`with_extra_labels`

Boolean that determines if the module provided extra labels will be installed.
Defaults is `true`.

###Defines

####edac::label

Defines EDAC labels for the motherboard FOO.

    edac::label { 'FOO':
      content => template('site_edac/foo.erb'),
    }

Defines two custom EDAC labels with their order set so FOO comes before BAR when written to the edac label file.

    edac::label { 'FOO':
      content => template('site_edac/foo.erb'),
      order   => '98',
    }
    edac::label { 'BAR':
      content => template('site_edac/bar.erb'),
      order   => '99',
    }

## Limitations

This module has only been tested against the following operating systems:

* CentOS 6.x
* Scientific Linux 6x
* CentOS 5.9

## Contributing

The best way to contribute is providing additional labels for motherboards.

## Development

Testing requires the following dependencies:

* rake
* bundler

Install gem dependencies

    bundle install

Run unit tests

    bundle exec rake test

If you have Vagrant >= 1.2.0 installed you can run system tests

    bundle exec rake beaker

## TODO

## Further Information

* [edac-utils](http://edac-utils.sourceforge.net/)
