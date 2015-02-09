require 'spec_helper'

describe command('php --ri svm') do
  its(:exit_status) { should eq 0 }
end

describe file('/var/log/php/error.log') do
  its(:content) { should_not match /Warning.*svm.*already loaded/ }
end
