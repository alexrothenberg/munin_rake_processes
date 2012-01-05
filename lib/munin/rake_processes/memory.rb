module Munin
  module RakeProcesses
    class Memory < Plugin

      def config
        puts <<-CONFIG
graph_args --lower-limit 0 --upper-limit 100
graph_category #{graph_category}
graph_info The % of Memory currently used by each running Rake processes - (possibly from cron)
graph_scale no
graph_title Current Memory utilization of Rake Processes
graph_vlabel Percent
        CONFIG
        rake_processes.each_key do |key|
          puts "#{key}_Memory.label #{key}_Memory"
        end
      end

      def run
        rake_processes.each do |cmd, values|
          puts "#{cmd}_Memory.value #{values[:memory]}"
        end
      end
    end
  end
end
