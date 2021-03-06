require 'spec_helper'

describe 'python::pip' do

  describe package('python') do
    it { should be_installed }
  end

  describe package('python-pip') do
    it { should be_installed }
  end

  describe command('which pip') do
    its(:exit_status) { should eq 0 }
  end

  describe command('pip freeze') do
    its(:stdout) { should match 'aws-ec2-assign-elastic-ip==0.1.0' }
  end

  describe command('which aws-ec2-assign-elastic-ip') do
    its(:exit_status) { should eq 0 }
  end
end
