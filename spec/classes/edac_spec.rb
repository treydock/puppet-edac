require 'spec_helper'

describe 'edac' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) { facts.merge(:concat_basedir => '/dne') }

      it { should compile.with_all_deps }
      it { should create_class('edac') }
      it { should contain_class('edac::params') }
      it { should contain_class('edac::extra') }

      it do
        should contain_package('edac-utils').with({
          :ensure => 'present',
          :name   => 'edac-utils',
        })
      end

      it do
        should contain_service('edac').with({
          :ensure   => nil,
          :enable   => 'true',
          :require  => 'Package[edac-utils]',
        })
      end

      it do
        should contain_exec('edac-register-labels').with({
          :path         => '/sbin:/bin:/usr/sbin:/usr/bin',
          :command      => 'edac-ctl --register-labels --quiet',
          :logoutput    => 'false',
          :refreshonly  => 'true',
          :subscribe    => 'Concat[edac.labels]',
        })
      end

      it do
        should contain_concat('edac.labels').with({
          :ensure   => 'present',
          :path     => '/etc/edac/labels.db',
          :owner    => 'root',
          :group    => 'root',
          :mode     => '0644',
          :require  => 'Package[edac-utils]',
        })
      end

      it do
        should contain_concat__fragment('edac.labels-main').with({
          :target => 'edac.labels',
          :source => 'puppet:///modules/edac/labels.db',
          :order  => '1',
        })
      end

      context 'when ensure => absent' do
        let(:params) {{ :ensure => 'absent' }}

        it { should_not contain_class('edac::extra') }
        it { should contain_package('edac-utils').with_ensure('absent') }
        it { should_not contain_service('edac') }
        it { should contain_exec('edac-register-labels').without_subscribe }
        it { should contain_concat('edac.labels').with_ensure('absent') }
      end
    end
  end
end
