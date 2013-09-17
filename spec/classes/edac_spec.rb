require 'spec_helper'

describe 'edac' do
  include_context :defaults

  let :facts do
    default_facts
  end

  it { should create_class('edac') }
  it { should contain_class('edac::params') }
  it { should include_class('edac::extra') }

  it do
    should contain_package('edac-utils').with({
      'ensure'    => 'present',
      'name'      => 'edac-utils',
    })
  end
  
  it do
    should contain_service('edac').with({
      'ensure'      => 'running',
      'name'        => 'edac',
      'enable'      => 'true',
      'hasstatus'   => 'true',
      'hasrestart'  => 'true',
      'require'     => 'Package[edac-utils]',
    })
  end

  it do
    should contain_concat_build('edac.labels').with({
      'order'   => ['*.db'],
      'target'  => '/etc/edac/labels.db',
      'require' => 'Package[edac-utils]',
      'notify'  => ['Service[edac]','File[/etc/edac/labels.db]'],
    })
  end

  it do
    should contain_file('/etc/edac/labels.db').with({
      'ensure'  => 'present',
      'owner'   => 'root',
      'group'   => 'root',
      'mode'    => '0644',
      'require' => ['Package[edac-utils]','Concat_build[edac.labels]'],
    })
  end

  it do
    should contain_concat_fragment('edac.labels+01_main.db')
  end
end
