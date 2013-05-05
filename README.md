# puppet-edac [![Build Status](https://travis-ci.org/treydock/puppet-edac.png)](https://travis-ci.org/treydock/puppet-edac)

This module manages installation and configuration of edac utilities for
Linux kernel EDAC drivers.

## Support

Tested using
* CentOS 5.9
* CentOS 6.4

## Usage

For standard edac-utils management

    class { 'edac': }

To add additional labels to labels.db

    edac::label { 'H8DGU':
      content => template('supermicro/h8dgu.erb'),
    }

## Development

### Dependencies

* Ruby 1.8.7
* Bundler

### Running tests

1. To install dependencies run `bundle install`
2. Run tests using `rake spec:all`

## Further Information

* [edac-utils](http://edac-utils.sourceforge.net/)