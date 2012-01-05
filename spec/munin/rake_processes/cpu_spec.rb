require 'spec_helper'
require 'stringio'

describe Munin::RakeProcesses::Cpu do
  before { stub_ps }
  
  around do |example|
    capture_output(&example)
  end

  describe '#config' do
    before do
      Munin::RakeProcesses::Cpu.new(['config'],{})
    end

    subject { captured_output }
    it { should == <<-OUTPUT
graph_args --lower-limit 0 --upper-limit 100
graph_category RakeProcesses
graph_info The % of CPU currently used by each running Rake processes - (possibly from cron)
graph_scale no
graph_title Current CPU utilization of Rake Processes
graph_vlabel Percent
some_user_25963_users_load.label some_user (25963) users:load
some_user_27461_users_load.label some_user (27461) users:load
some_user_27499_cron.label some_user (27499) cron
OUTPUT
    }
  end

  describe '#run' do
    before do
      Munin::RakeProcesses::Cpu.new([],{})
    end

    subject { captured_output }
    it { should == <<-OUTPUT
some_user_25963_users_load.value 5.0
some_user_27461_users_load.value 0.0
some_user_27499_cron.value 90.0
OUTPUT
    }
  end
end
