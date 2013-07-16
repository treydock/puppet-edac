require 'puppetlabs_spec_helper/module_spec_helper'

shared_context :defaults do
  let :default_facts do
    {
      :osfamily               => 'RedHat',
      :operatingsystem        => 'CentOS',
      :operatingsystemrelease => '6.4',
      :concat_basedir         => '/var/lib/puppet/concat',
    }
  end
end
