require 'rspec-system/spec_helper'
require 'rspec-system-puppet/helpers'

include RSpecSystemPuppet::Helpers

RSpec.configure do |c|
  proj_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))
  # Enable colour in Jenkins
  c.tty = true

  c.include RSpecSystemPuppet::Helpers

  # This is where we 'setup' the nodes before running our tests
  c.before :suite do
    # Install puppet
    puppet_install
    puppet_master_install

    # Install module dependencies
    shell('puppet module install puppetlabs/stdlib --modulepath /etc/puppet/modules --force')
    shell('puppet module install theforeman/concat_native --modulepath /etc/puppet/modules --force')
    
    # Install edac module
    puppet_module_install(:source => proj_root, :module_name => 'edac')
  end
end