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

      def run_command(command, debug = false)
        result = `#{command}`

        unless $?.success?
          $stderr.puts "failed executing #{command}"
          exit 1
        end

        puts result if debug

        result
      end

      def rake_processes
        @rake_processes ||= begin
          _rake_processes = {}
          rake_process_lines = run_command('ps aux | grep rake | grep -v grep | grep -v /etc/munin/plugins', debug).split("\n")
          rake_process_lines.each do |rake_process|
            cmd  = rake_process[65,1000]
            cmd =~ /rake([^-]+)/
            rake_cmd = $1.split('-').first.strip.gsub(/[^\w]/, '_')
            time = rake_process[60,5].strip
            time =~ /(\d+):(\d+)$/
            time_in_seconds = $1.to_i*60 + $2.to_i
            user = rake_process[0,9].strip
            pid  = rake_process[10,5].strip
            label = "#{user}_#{pid}_#{rake_cmd}"
            _rake_processes[label] = {:cpu => rake_process[16,4].strip, :mem => rake_process[21,4].strip, :time => time_in_seconds}
          end
          _rake_processes
        end
      end
    end
  end
end
