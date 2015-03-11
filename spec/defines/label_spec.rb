require 'spec_helper'

describe 'edac::label' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) { facts }
      let(:title) { 'foo' }
      let(:params) {{ :content => 'bar' }}

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
  end
end
