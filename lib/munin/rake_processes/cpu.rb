module Munin
  module RakeProcesses
    class Cpu < Plugin

      def config
        puts <<-CONFIG
graph_args --lower-limit 0 --upper-limit 100
graph_category #{graph_category}
graph_info The % of CPU currently used by each running Rake processes - (possibly from cron)
graph_scale no
graph_title Current CPU utilization of Rake Processes
graph_vlabel Percent
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
