require 'spec_helper'

describe command('php --ri stats') do
  its(:exit_status) { should eq 0 }
end

describe file('/var/log/php/error.log') do
  its(:content) { should_not match /Warning.*stats.*already loaded/ }
end
