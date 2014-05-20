require 'spec_helper'

describe 'edac::extra' do
  include_context :defaults

  let :facts do
    default_facts
  end
  
  it { should create_class('edac::extra') }
  it { should contain_class('edac::extra::supermicro') }

end
