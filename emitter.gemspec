# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "emitter/version"

Gem::Specification.new do |s|
  s.name        = 'emitter'
  s.version     = Emitter::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Andy Rossmeissl", "Seamus Abshere", "Ian Hough", "Matt Kling", 'Derek Kastner']
  s.email       = %q{derek@brighterplanet.com}
  s.homepage    = "https://github.com/brighterplanet/emitter"
  s.summary     = %q{The mother of all carbon models}
  s.description = %q{A software model in Ruby for the greenhouse gas emissions}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency 'activerecord', '~>3'
  s.add_development_dependency 'sniff'
  s.add_dependency 'activesupport', '>=2.3.4'
  s.add_dependency 'characterizable'
  s.add_dependency 'cohort_scope'
  s.add_dependency 'data_miner', '>=1.1' unless ENV['LOCAL_DATA_MINER']
  s.add_dependency 'earth' unless ENV['LOCAL_EARTH']
  s.add_dependency 'falls_back_on' unless ENV['LOCAL_FALLS_BACK_ON']
  s.add_dependency 'leap' unless ENV['LOCAL_LEAP']
  s.add_dependency 'summary_judgement'
  s.add_dependency 'timeframe'
  s.add_dependency 'weighted_average'
end
