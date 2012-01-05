require 'fileutils'
module Munin
  module RakeProcesses
    class Installer
      def initialize(args)
        if args.empty?
          add_all_plugins
        else
          args.each do |plugin|
            add_plugin(plugin)
          end
        end
      end
      
      def add_all_plugins
        [:count, :cpu, :cpu_time, :memory].each do |plugin|
          add_plugin(plugin)
        end
      end

      def add_plugin(plugin)
        plugin_filename = "munin_rake_processes_#{plugin}"
        plugin_path = `which #{plugin_filename}`
        FileUtils.mkdir_p(munin_plugins_path)      
        `ln -nsf "#{plugin_path}" "#{munin_plugins_path}/#{plugin_filename}"`      
        puts "Installing Munin plugin #{plugin_filename}"
      end

      def munin_plugins_path
        "/etc/munin/plugins"
      end
    end
  end
end