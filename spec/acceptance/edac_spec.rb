require 'spec_helper_acceptance'

describe 'edac class:' do
  shared_examples 'edac' do
    describe package('edac-utils') do
      it { should be_installed }
    end

    describe service('edac') do
      it { should be_enabled }
    end
  end

  context 'with_extra_labels => false' do
    it 'should run succcessfully' do
      pp = <<-EOS
        class { 'edac': with_extra_labels => false }
      EOS

      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes => true)
    end

    it_behaves_like "edac"

    describe file('/etc/edac/labels.db') do
      it { should be_file }
      it { should contain 'Vendor: Supermicro' }
      it { should_not contain 'Model: H8DGU' }
    end
  end

  context 'with default parameters' do
    it 'should run succcessfully' do
      pp = <<-EOS
        class { 'edac': }
      EOS

      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes => true)
    end

    it_behaves_like "edac"

    describe file('/etc/edac/labels.db') do
      it { should be_file }
      it { should contain 'Vendor: Supermicro' }
      it { should contain 'Model: H8DGU' }
    end
  end

  context 'with ensure => absent' do
    it 'should run succcessfully' do
      pp = <<-EOS
        class { 'edac': ensure => 'absent' }
      EOS

      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes => true)
    end

    describe package('edac-utils') do
      it { should_not be_installed }
    end

    describe service('edac') do
      it { should_not be_enabled }
    end

    describe file('/etc/edac/labels.db') do
      it { should_not be_file }
    end
  end
end
