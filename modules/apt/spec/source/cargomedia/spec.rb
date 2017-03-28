require 'spec_helper'

describe 'apt::source::vrenetic' do

  describe file('/etc/apt/sources.list.d/vrenetic.list') do
    it { should be_file }
  end

  describe command('apt-key list') do
    its(:stdout) { should match /pub+.*2048R\/4A45CD8B/ }
    its(:stdout) { should match /VRenetic Tech <tech@vrenetic.io>/ }
  end

end
