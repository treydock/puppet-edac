require 'spec_helper'

describe 'edac::extra::supermicro' do
  include_context :defaults

  let :facts do
    default_facts
  end
  
  it { should create_class('edac::extra::supermicro') }

  it do
    should contain_edac__label('edac::extra::supermicro').with({
      'order'   => '02',
    }) \
      .with_content(/^Vendor: Supermicro$/) \
      .with_content(/^\s+Model: H8DGU$/) \
      .with_content(/^\s+Model: H8QG6, H8QGi$/) \
      .with_content(/^\s+Model: X9DRi-LN4\+\/X9DR3-LN4\+$/)
  end
end
