module Munin
  module RakeProcesses
    class CpuTime < Plugin

      def config
        puts <<-CONFIG
graph_category #{graph_category}
graph_info The seconds of cumulative CPU time consumed by each Rake processes
graph_title Cumulative CPU Time of Rake Processes
graph_vlabel Seconds
        CONFIG
        rake_processes.each_key do |key|
          puts "#{key}_TIME.label #{key}_TIME"
        end
      end

      def run
        rake_processes.each do |cmd, values|
          puts "#{cmd}_TIME.value #{values[:time]}"
        end
      end
    end
  end
end
