require 'spec_helper'

describe 'edac::label' do
  include_context :defaults

  let :facts do
    default_facts
  end

  let :title do
    'foo'
  end

  let :params do 
    { :content => 'bar' }
  end

  it { should contain_class('edac') }

  it { should create_edac__label('foo') }

  it do
    should contain_concat_fragment('edac.labels+99_foo.db').with_content(/^bar$/)
  end

  context 'with defined order' do
    let(:params) { { :order => '03', :content => 'bar' } }

    it do
      should contain_concat_fragment('edac.labels+03_foo.db').with_content(/^bar$/)
    end
  end
end
