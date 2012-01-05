module Munin
  module RakeProcesses
    class Cpu < Plugin

      def config
        puts <<-CONFIG
graph_category #{graph_category}
graph_title CPU usage of Rake Processes
graph_vlabel CPU usage of Rake Processes
graph_info The CPU usage of Rake processes currently running - (possibly from cron)
        CONFIG
        rake_processes.each_key do |key|
          puts "#{key}_CPU.label #{key}_CPU"
        end
      end

      def run
        rake_processes.each do |cmd, values|
          puts "#{cmd}_CPU.value #{values[:cpu]}"
        end
      end
    end
  end
end
