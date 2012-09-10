# -*- encoding: utf-8 -*-
require File.expand_path("../lib/emitter/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = 'emitter'
  s.version     = Emitter::VERSION
  s.authors     = ["Andy Rossmeissl", "Seamus Abshere", "Ian Hough", "Matt Kling", 'Derek Kastner']
  s.email       = ['andy@rossmeissl.net', "seamus@abshere.net", "ijhough@gmail.com", "matt.kling@gmail.com", "dkastner@gmail.com"]
  s.homepage    = "https://github.com/brighterplanet/emitter"
  s.summary     = %q{A framework for modelling the impact of real-world entities.}
  s.description = %q{A framework for modelling the impact of real-world entities.}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'activerecord', '~>3'
  s.add_dependency 'active_record_inline_schema'
  s.add_dependency 'activesupport', '>=2.3.10'
  s.add_dependency 'charisma'
  s.add_dependency 'data_miner', '>=2' unless ENV['LOCAL_DATA_MINER']
  s.add_dependency 'falls_back_on'
  s.add_dependency 'leap', '>=0.5.4'
  s.add_dependency 'summary_judgement'
  s.add_dependency 'timeframe'
  s.add_dependency 'weighted_average'

  s.add_development_dependency 'bueller'
  s.add_development_dependency 'activerecord-mysql2-adapter'
  s.add_development_dependency 'rspec'
end
