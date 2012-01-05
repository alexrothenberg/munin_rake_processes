module Munin
  module RakeProcesses
    class Plugin
      attr_accessor :debug
      attr_accessor :graph_category

      def initialize(args, environment={})
        self.graph_category = environment['graph_category'] || 'RakeProcesses'            

        case args[0]
        when "config"   
          config
        when "autoconf"  
          autoconf
        else                 
          run
        end
      end

      def self.rake_ps_string
        `(ps -eo user,pid,%cpu,%mem,cputime,command | grep rake | grep -v grep | grep -v munin`        
      end
      
      def rake_processes
        @rake_processes ||= begin
          _rake_processes = {}
          rake_ps_lines = self.class.rake_ps_string.split("\n")
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
      end
      
      def run
        # subclass me 
      end
      
    end
  end
end
