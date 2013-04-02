
    Gem::Specification Reference
    Full episode source code

```bash

bundle gem lorem
gem build lorem.gemspec
gem push lorem-0.0.1.gem
bundle
rake -T
rake build
rake install
rake release
```
lorem.gemspec
```
# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "lorem/version"

Gem::Specification.new do |s|
  s.name        = "lorem"
  s.version     = Lorem::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Ryan Bates"]
  s.email       = ["ryan@railscasts.com"]
  s.homepage    = ""
  s.summary     = %q{Lorem ipsum generator}
  s.description = %q{Simply generates lorem ipsum text.}
  
  s.add_development_dependency "rspec"

  s.rubyforge_project = "lorem"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f|
File.basename(f) }
  s.require_paths = ["lib"]
end
```
Gemfile
```
source "http://rubygems.org"
```
Specify your gem's dependencies in lorem.gemspec
```
gemspec
```
Rakefile
```
require 'bundler'
Bundler::GemHelper.install_tasks
```
lib/lorem.rb
```
module Lorem
  def self.ipsum
    "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do
eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad
minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip
ex ea commodo consequat. Duis aute irure dolor in reprehenderit in
voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur
sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt
mollit anim id est laborum."
  end
end
```
lib/lorem/version.rb
```
module Lorem
  VERSION = "0.0.2"
end
```
http://railscasts.com/episodes/245-new-gem-with-bundler
