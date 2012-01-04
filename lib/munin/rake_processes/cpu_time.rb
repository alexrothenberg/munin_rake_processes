module Munin
  module RakeProcesses
    class CpuTime < Plugin

      def config
        puts <<-CONFIG
          graph_category #{graph_category}
          graph_title CPU Time of Rake Processes
          graph_vlabel CPU Time of Rake Processes
          graph_info The CPU time consumed of Rake processes currently running - (possibly from cron)
        CONFIG
        rake_processes.each_key do |key|
          puts "#{key}_TIME.label #{key}_TIME"
        end

        exit 0
      end

      def run
        rake_processes.each do |cmd, values|
          puts "#{cmd}_TIME.value #{values[:time]}"
        end
      end
    end
  end
end
