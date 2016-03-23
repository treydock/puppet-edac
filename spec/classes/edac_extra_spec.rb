require 'spec_helper'

describe 'edac::extra' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) { facts.merge(:concat_basedir => '/dne') }
  
      it { should create_class('edac::extra') }
      it { should contain_class('edac::extra::supermicro') }
    end
  end
end
