require 'munin_rake_processes'

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |c|
end


def stub_ps
  Munin::RakeProcesses::Plugin.stub(:'`').and_return <<-PS_STRING
some_user      25963   5.0  0.2  140:48.69 ruby /Users/alex/.rvm/gems/ruby-1.8.7-p334/bin/rake users:load
some_user      27461   0.0  0.1   00:00:00 ruby /Users/alex/.rvm/gems/ruby-1.8.7-p334/bin/rake users:load
some_user      27499  90.0  0.3    0:02.30 ruby /Users/alex/.rvm/gems/ruby-1.8.7-p334/bin/rake cron
PS_STRING
end

def capture_output
  $o_stdin, $o_stdout, $o_stderr = $stdin, $stdout, $stderr
  $stdin, $stdout, $stderr = StringIO.new, StringIO.new, StringIO.new

  yield

ensure
  $stdin, $stdout, $stderr = $o_stdin, $o_stdout, $o_stderr
end

def captured_output
  sort_stdout_if_ruby_18
  $stdout.string
end

def sort_stdout_if_ruby_18
  if RUBY_VERSION < '1.9'  
    $stdout.string = $stdout.string.split("\n").sort.join("\n") + "\n"
  end
end
