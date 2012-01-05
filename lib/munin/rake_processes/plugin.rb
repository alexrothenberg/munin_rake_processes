module Munin
  module RakeProcesses
    class Plugin
      attr_accessor :debug
      attr_accessor :graph_category

      def initialize(args, env)
        self.graph_category = 'app'

        if args[0] == "config"
          config
        elsif args[0] == "autoconf"
          autoconf
        end
      end

      def rake_processes
        @rake_processes ||= begin
          _rake_processes = {}
          rake_ps_lines = `ps -eo user,pid,%cpu,%mem,cputime,command | grep rake | grep -v grep | grep -v munin`.split("\n")
          rake_ps_lines.each do |ps_line|
            user, pid, cpu, memory, cpu_time, cmd = ps_line.split ' ', 6
            cmd =~ /rake([^-]+)/
            rake_cmd = $1.split('-').first.strip.gsub(/[^\w]/, '_')
            label = "#{user}_#{pid}_#{rake_cmd}"
            time_in_seconds = Time.parse("1-1-1970 #{cpu_time}") - Time.parse('1-1-1970 00:00')
            _rake_processes[label] = {:cpu => cpu, :memory => memory, :time => time_in_seconds}
          end
          _rake_processes
        end
      end
      
      def autoconf
        puts "yes"
        exit 0      
      end
    end
  end
end
