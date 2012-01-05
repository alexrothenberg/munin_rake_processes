require 'spec_helper'
require 'stringio'

describe Munin::RakeProcesses::Count do
  before { stub_ps }
  
  around do |example|
    capture_output(&example)
  end

  describe '#config' do
    before do
      Munin::RakeProcesses::Count.new(['config'],{})
    end

    subject { $stdout.string }
    it { should == <<-OUTPUT
graph_category RakeProcesses
graph_title Number of Rake Processes
graph_vlabel Count of Rake Processes
graph_info The Rake processes running - (possibly from cron)
rake_processes.label rake_processes
OUTPUT
    }
  end

  describe '#run' do
    before do
      Munin::RakeProcesses::Count.new([],{})
    end

    subject { $stdout.string }
    it { should == <<-OUTPUT
rake_processes.value 3
OUTPUT
    }
  end
end
