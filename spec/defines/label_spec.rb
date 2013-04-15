require 'spec_helper'

describe 'edac::label' do
  
  let(:facts) { { :osfamily => 'RedHat' } }

  let(:title) { 'foo' }

  let(:params) { { :content => 'bar' } }

  it { should contain_class('edac') }

  it { should contain_concat_fragment('edac.labels.db+99_foo.db') }
  
  it do
    should contain_concat_fragment('edac.labels.db+99_foo.db') \
      .with_content(/^bar$/)
  end
  
  context 'with defined order' do
    let(:params) { { :order => '03', :content => 'bar' } }
    
    it do
      should contain_concat_fragment('edac.labels.db+03_foo.db') \
        .with_content(/^bar$/)
    end
  end
end
