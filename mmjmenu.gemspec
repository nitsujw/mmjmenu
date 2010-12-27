# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "mmjmenu/version"

Gem::Specification.new do |s|
  s.name        = "mmjmenu"
  s.version     = Mmjmenu::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Justin Weidmann", "Alex Weidmann"]
  s.email       = ["justin@mmjmenu.com", "alex@mmjmenu.com"]
  s.homepage    = "http://rubygems.org/gems/mmjmenu"
  s.summary     = %q{Ruby wrapper for mmjmenu.com API}
  s.description = %q{Ruby wrapper for mmjmenu.com API}

  s.rubyforge_project = "mmjmenu"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
