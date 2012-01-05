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

    subject { $stdout.string }
    it { should == <<-OUTPUT
graph_category RakeProcesses
graph_title CPU Time of Rake Processes
graph_vlabel CPU Time of Rake Processes
graph_info The CPU time consumed of Rake processes currently running - (possibly from cron)
some_user_27461_load_users_TIME.label some_user_27461_load_users_TIME
some_user_25963_load_users_TIME.label some_user_25963_load_users_TIME
some_user_27499_cron_TIME.label some_user_27499_cron_TIME
OUTPUT
    }
  end

  describe '#run' do
    before do
      Munin::RakeProcesses::CpuTime.new([],{})
    end

    subject { $stdout.string }
    it { should == <<-OUTPUT
some_user_27461_load_users_TIME.value 0.0
some_user_25963_load_users_TIME.value 4959.0
some_user_27499_cron_TIME.value 120.0
OUTPUT
    }
  end
end
