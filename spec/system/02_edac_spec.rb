require 'spec_helper_system'

describe 'edac class:' do
  context 'should run successfully' do
    pp = <<-EOS
      class { 'edac': }
    EOS

    context puppet_apply(pp) do
      its(:stderr) { should be_empty }
      its(:exit_code) { should_not == 1 }
      its(:refresh) { should be_nil }
      its(:stderr) { should be_empty }
      its(:exit_code) { should be_zero }
    end
  end

  describe package('edac-utils') do
    it { should be_installed }
  end

  describe service('edac') do
    it { should be_enabled }
    it { should be_running }
  end

  describe file('/etc/edac/labels.db') do
    it { should be_file }
    it { should contain 'Vendor: Supermicro' }
    it { should contain 'Model: H8DGU' }
  end
end
