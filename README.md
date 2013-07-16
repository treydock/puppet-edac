# puppet-edac [![Build Status](https://travis-ci.org/treydock/puppet-edac.png)](https://travis-ci.org/treydock/puppet-edac)

This module manages installation and configuration of edac utilities for
Linux kernel EDAC drivers.

## Support

Tested using

* CentOS 6.4
* CentOS 5.9

## Dependencies

* [puppetlabs/stdlib](http://forge.puppetlabs.com/puppetlabs/stdlib)
* [theforeman/concat_native](http://forge.puppetlabs.com/theforeman/concat_native)

## Usage

For standard edac-utils management

    class { 'edac': }

To add additional labels to labels.db

    edac::label { 'H8DGU':
      content => template('supermicro/h8dgu.erb'),
    }

The example above is provided by the `edac::extra::supermicro`

## Contributing

The best way to contribute is providing additional labels for motherboards.

## Development

### Dependencies

* Bundler

### Running tests

Install Gem dependencies

    bundle install

Run tests

    bundle exec rake ci

### System tests

If you have Vagrant >= 1.1.0 you can system tests

    bundle exec rake spec:system

## Further Information

* [edac-utils](http://edac-utils.sourceforge.net/)