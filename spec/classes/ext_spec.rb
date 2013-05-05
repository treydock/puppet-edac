require 'spec_helper'

describe 'edac::extra' do

  let :facts do
    RSpec.configuration.default_facts.merge({
    })
  end
  
  it { should contain_class('edac::extra::supermicro') }

  context 'edac::extra::supermicro' do
    it do
      should contain_edac__label('edac::extra::supermicro').with({
        'order'   => '02',
      })
    end

    context 'supermicro edac::label define' do
      it do
        should contain_concat_fragment('edac.labels.db+02_edac::extra::supermicro.db') \
          .with_content(/^Vendor: Supermicro$/) \
          .with_content(/^\s+Model: H8DGU$/)
      end
    end
  end
end
