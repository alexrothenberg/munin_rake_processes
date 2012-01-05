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
        `ps -eo user,pid,%cpu,%mem,cputime,command | grep -v -e grep -e munin | grep rake`
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
            time_in_seconds = ps_time_to_seconds(cpu_time)
            _rake_processes[label] = {:cpu => cpu, :memory => memory, :time => time_in_seconds}
          end
          _rake_processes
        end
      end

      def autoconf
        puts "yes"
      end

      def run
        # overridden in subclasses but left here for rspec plugin_spec.rb
      end

      private
      def ps_time_to_seconds(time_string)
        seconds = 0
        time_elements = time_string.split(':').reverse
        time_elements.each_with_index {|element,index| seconds += element.to_f*(60**index)}
        seconds
      end
    end
  end
end
