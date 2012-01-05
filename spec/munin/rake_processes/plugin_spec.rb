require 'spec_helper'

describe Munin::RakeProcesses::Plugin do
  describe '#rake_processes' do
    before do
      stub_ps
    end
    let(:rake_processes) { Munin::RakeProcesses::Plugin.new([],{}).rake_processes }
    subject { rake_processes }
    its(:size) { should == 3 }

    describe 'old load_users' do
      subject { rake_processes['some_user_25963_load_users'] }
      its([:cpu   ]) { should == '5.0' }
      its([:memory]) { should == '0.2' }
      its([:time  ]) { should == 4959.0 }
    end

    describe 'hung old load_users' do
      subject { rake_processes['some_user_27461_load_users'] }
      its([:cpu   ]) { should == '0.0' }
      its([:memory]) { should == '0.1' }
      its([:time  ]) { should == 0.0 }
    end

    describe 'hung old load_users' do
      subject { rake_processes['some_user_27499_cron'] }
      its([:cpu   ]) { should == '90.0' }
      its([:memory]) { should == '0.3' }
      its([:time  ]) { should == 120.0 }
    end
  end
end
