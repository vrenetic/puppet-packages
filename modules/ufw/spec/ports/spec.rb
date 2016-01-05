require 'spec_helper'

describe 'ufw::ports' do

  describe command('ufw status numbered') {
    its(:stdout) { should match /Description: weird server/ }
    its(:stdout) { should match /21,23:25\/tcp/ }
    its(:stdout) { should match /10000:15000\/udp/ }
  }

  describe iptables do
    it { should have_rule('-m multiport --dports 10000:15000').with_table('filter').with_chain('ufw-user-input') }
  end
end
