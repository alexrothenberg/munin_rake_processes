module Munin
  module RakeProcesses
    class Count < Plugin

      def config
        puts <<-CONFIG
graph_category #{graph_category}
graph_title Number of Rake Processes
graph_vlabel Count of Rake Processes
graph_info The Rake processes running - (possibly from cron)
rake_processes.label rake_processes
        CONFIG
      end

      def run
        puts "rake_processes.value #{rake_processes.size}"
      end
    end
  end
end
