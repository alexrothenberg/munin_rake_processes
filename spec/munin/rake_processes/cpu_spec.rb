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

    subject { $stdout.string }
    it { should == <<-OUTPUT
graph_category RakeProcesses
graph_title CPU usage of Rake Processes
graph_vlabel CPU usage of Rake Processes
graph_info The CPU usage of Rake processes currently running - (possibly from cron)
some_user_27461_load_users_CPU.label some_user_27461_load_users_CPU
some_user_25963_load_users_CPU.label some_user_25963_load_users_CPU
some_user_27499_cron_CPU.label some_user_27499_cron_CPU
OUTPUT
    }
  end

  describe '#run' do
    before do
      Munin::RakeProcesses::Cpu.new([],{})
    end

    subject { $stdout.string }
    it { should == <<-OUTPUT
some_user_27461_load_users_CPU.value 0.0
some_user_25963_load_users_CPU.value 5.0
some_user_27499_cron_CPU.value 90.0
OUTPUT
    }
  end
end