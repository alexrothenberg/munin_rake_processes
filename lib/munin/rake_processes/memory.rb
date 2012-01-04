module Munin
  module RakeProcesses
    class Memory < Plugin

      def config
        puts <<-CONFIG
          graph_category #{graph_category}
          graph_title Memory usage of Rake Processes
          graph_vlabel Memory usage of Rake Processes
          graph_info The Memory usage of Rake processes currently running - (possibly from cron)
        CONFIG
        rake_processes.each_key do |key|
          puts "#{key}_Memory.label #{key}_Memory"
        end

        exit 0
      end

      def run
        rake_processes.each do |cmd, values|
          puts "#{cmd}_Memory.value #{values[:memory]}"
        end
      end
    end
  end
end