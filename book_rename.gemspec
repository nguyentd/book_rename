# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "book_rename/version"

Gem::Specification.new do |s|
  s.name        = "book_rename"
  s.version     = BookRename::VERSION
  s.authors     = ["Merlin"]
  s.email       = ["merlinvn@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{}
  s.description = %q{This gem with find and rename pdf ebook using amazon service}

  s.rubyforge_project = "book_rename"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
  s.add_dependency "thor"
  
end
