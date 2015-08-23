## treydock-edac changelog

Release notes for the treydock-edac module.

#### 2015-08-23 - Release 1.0.0

This release contains backwards incompatible changes.

##### Backwards incompatible changes

* Remove the following parameters
  * `edac_service_hasstatus`
  * `edac_service_hasrestart`
* Only manage the edac service's `enable` property

##### Features

* Add `edac_service_enable` parameter that determines if the edac service should start on boot
* Add `ensure` parameter
* Use an Exec resource to register labels when labels.db is modified
* Added additional labels that were pulled from edac source code

------------------------------------------

#### 2015-02-03 Release 0.1.1

This release focused on updating testing and modernizing module with no changes made to the modules functionality.

Detailed Changes:

* Expand travis-ci test coverage
* Replace use of Modulefile with metadata.json
* Update development dependencies
* Update Rakefile to match updated gem dependencies
* Run puppet-lint --fix which corrected indentation
* Add puppet-lint config file

------------------------------------------

#### 2014-05-20 Release 0.1.0

This minor feature release adds additional Supermicro labels and
a refactor to the regression tests.

Detailed Changes:

* Add labels for Supermicro H8QG6, H8QGi
* Specific module versions used for rspec-puppet fixtures
* Add Puppet 3.4.x and 3.5.x to Travis-CI tests
* Replace rspec-system tests with beaker-rspec
* Add LICENSE file
* Updated .gitignore
