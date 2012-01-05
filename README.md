# Munin Rake Processes [![Build Status](https://secure.travis-ci.org/alexrothenberg/munin_rake_processes.png)](http://travis-ci.org/alexrothenberg/munin_rake_processes)

Some Munin plugins to monitor running rake tasks.

Rake tasks are often run on the server using cron or some other scheduler. This gem lets you monitor so you can tell

* how many are running
* how long they've been running
* how much cpu they are using
* how much memory they are using

# Usage

    gem install munin_rake_processes
    
    munin_rake_processes_installer
    # will install all 4 munin plugins

    munin_rake_processes_installer count
    # will install just the count munin plugin

    munin_rake_processes_installer count cpu_time
    # will install just the count and cpu_time munin plugins (any combination will work)

# Contributing

* Check out the latest master to make sure the feature hasn’t been implemented or the bug hasn’t been fixed yet
* Check out the issue tracker to make sure someone already hasn’t requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for it. This is important so I don’t break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

# Copyright

Copyright © 2011 Alex Rothenberg. See LICENSE.txt for further details.
