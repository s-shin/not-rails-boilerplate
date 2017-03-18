# Not Rails Boilerplate

**WIP**

A boilerplate for development of web application without rails in ruby.

## Overview

```
Rakefile
Gemfile
Capfile

# boot.rb does common initial setup so it should be always required first.
boot.rb

config/
    # any config files
    xxx.yml
    # capistrano settings
    deploy.rb
    deploy/xxx.rb

lib/
    app/ # all application codes in this
    xxx.rb # isolated/reusable codes is placed outside app directory

test/ # directory structure corresponds to lib
    app/
    test_xxx.rb
```

## Modules

* Task runner: `rake`
* Test: `test-unit`, `factory_girl`, `rack-test`
* Web server: `rask` and favorite server (e.g. unicorn, puma)
* Web application framework: `sinatra`, `grape`, or favorite minimal frameworks
* Database: `sequel`, `ridgepole`, and adapters
* Linter: `rubocop`
* Document: `yard`
* Debug: `pry-byebug`
* Console: `pry`
* Misc: `activesupport`
* Deploy: `capistrano`
