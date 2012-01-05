module Munin
  module RakeProcesses
    class Memory < Plugin

      def config
        puts <<-CONFIG
graph_category #{graph_category}
graph_info The Memory usage of Rake processes currently running - (possibly from cron)
graph_title Memory usage of Rake Processes
graph_vlabel Memory usage of Rake Processes
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
