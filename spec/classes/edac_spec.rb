require 'spec_helper'

describe 'edac' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) { facts }

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
          :subscribe    => 'File[/etc/edac/labels.db]',
        })
      end

      it do
        should contain_concat_build('edac.labels').with({
          :order    => ['*.db'],
          :require  => 'Package[edac-utils]',
          #:notify   => 'File[/etc/edac/labels.db]',
        })
      end

      it do
        should contain_file('/etc/edac/labels.db').with({
          :ensure   => 'present',
          :owner    => 'root',
          :group    => 'root',
          :mode     => '0644',
          :require  => 'Concat_build[edac.labels]',
        })
      end

      it do
        should contain_concat_fragment('edac.labels+01_main.db')
      end
    end
  end
end
