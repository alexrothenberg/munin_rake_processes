# -*- encoding: utf-8 -*-
require File.expand_path('../lib/munin/rake_processes/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Alex Rothenberg"]
  gem.email         = ["alex@alexrothenberg.com"]
  gem.description   = %q{Munin tasks for monitoring rake processes}
  gem.summary       = %q{Munin tasks for monitoring rake processes}
  gem.homepage      = ""

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "munin_rake_processes"
  gem.require_paths = ["lib"]
  gem.version       = Munin::RakeProcesses::VERSION

  gem.post_install_message = <<-POST_INSTALL_MESSAGE
  #{"*" * 80}

    To install these munin plugins and start monitoring your rake processes run

      munin_rake_processes_installer

    Enjoy!

  #{"*" * 80}
    POST_INSTALL_MESSAGE

  gem.add_development_dependency 'rspec', '>= 2.2'
  gem.add_development_dependency 'rake'

end
