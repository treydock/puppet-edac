require 'spec_helper'

describe 'edac::extra::supermicro' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) { facts.merge(:concat_basedir => '/dne') }
  
      it { should create_class('edac::extra::supermicro') }

      it do
        should contain_edac__label('edac::extra::supermicro').with({
          :source => 'puppet:///modules/edac/supermicro.db',
          :order  => '2',
        })
      end
    end
  end
end
