## treydock-edac changelog

Release notes for the treydock-edac module.

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
