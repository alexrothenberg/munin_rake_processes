require 'spec_helper'
require 'stringio'

describe Munin::RakeProcesses::CpuTime do
  before { stub_ps }
  
  around do |example|
    capture_output(&example)
  end

  describe '#config' do
    before do
      Munin::RakeProcesses::CpuTime.new(['config'],{})
    end

    subject { captured_output }
    it { should == <<-OUTPUT
graph_category RakeProcesses
graph_info The seconds of cumulative CPU time consumed by each Rake processes
graph_title Cumulative CPU Time of Rake Processes
graph_vlabel Seconds
some_user_25963_load_users_TIME.label some_user_25963_load_users_TIME
some_user_27461_load_users_TIME.label some_user_27461_load_users_TIME
some_user_27499_cron_TIME.label some_user_27499_cron_TIME
OUTPUT
    }
  end

  describe '#run' do
    before do
      Munin::RakeProcesses::CpuTime.new([],{})
    end

    subject { captured_output }
    it { should == <<-OUTPUT
some_user_25963_load_users_TIME.value 8448.69
some_user_27461_load_users_TIME.value 0.0
some_user_27499_cron_TIME.value 2.3
OUTPUT
    }
  end
end
