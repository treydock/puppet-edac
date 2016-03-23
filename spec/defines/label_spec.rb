require 'spec_helper'

describe 'edac::label' do
  on_supported_os.each do |os, facts|
    context "on #{os}" do
      let(:facts) { facts.merge(:concat_basedir => '/dne') }
      let(:title) { 'foo' }
      let(:params) {{ :content => 'bar' }}

      it { should contain_class('edac') }

      it { should create_edac__label('foo') }

      it do
        should contain_concat__fragment('edac.labels-foo').with({
          :target   => 'edac.labels',
          :content  => /^bar$/,
          :order    => '99',
        })
      end

      context 'with defined order' do
        let(:params) { { :order => '03', :content => 'bar' } }

        it do
          should contain_concat__fragment('edac.labels-foo').with_order('03')
        end
      end
    end
  end
end
