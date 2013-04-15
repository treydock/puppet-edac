require 'spec_helper'

describe 'edac' do

  let :facts do
    {
      :osfamily => 'RedHat',
    }
  end

  it { should contain_class('edac::params') }
  it { should contain_class('edac::extra') }

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
    should contain_concat_build('edac.labels.db').with({
      'order'   => ['*.db'],
      'target'  => '/etc/edac/labels.db',
      'require' => 'Package[edac-utils]',
      'notify'  => 'Service[edac]',
    })
  end
  
  it do
    should contain_file('/etc/edac/labels.db').with({
      'owner'   => 'root',
      'group'   => 'root',
      'mode'    => '0644',
      'require' => 'Package[edac-utils]',
    })
  end
  
  it { should contain_concat_fragment('edac.labels.db+01_main.db') }

end
