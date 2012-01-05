require 'spec_helper'
require 'stringio'

describe Munin::RakeProcesses::Memory do
  before { stub_ps }
  
  around do |example|
    capture_output(&example)
  end

  describe '#config' do
    before do
      Munin::RakeProcesses::Memory.new(['config'],{})
    end

    subject { captured_output }
    it { should == <<-OUTPUT
graph_args --lower-limit 0 --upper-limit 100
graph_category RakeProcesses
graph_info The % of Memory currently used by each running Rake processes - (possibly from cron)
graph_scale no
graph_title Current Memory utilization of Rake Processes
graph_vlabel Percent
some_user_25963_load_users_Memory.label some_user_25963_load_users_Memory
some_user_27461_load_users_Memory.label some_user_27461_load_users_Memory
some_user_27499_cron_Memory.label some_user_27499_cron_Memory
OUTPUT
    }
  end

  describe '#run' do
    before do
      Munin::RakeProcesses::Memory.new([],{})
    end

    subject { captured_output }
    it { should == <<-OUTPUT
some_user_25963_load_users_Memory.value 0.2
some_user_27461_load_users_Memory.value 0.1
some_user_27499_cron_Memory.value 0.3
OUTPUT
    }
  end
end
