# emitter

Base module for Brighter Planet's emitters. See the [Brighter Planet developer page](http://brighterplanet.github.com) for details on Brighter Planet's development environment.

## Installation

    $ gem install emitter

## Usage

    # my_emitter.rb
    require 'emitter'
    
    class MyEmitter
      include BrighterPlanet::Emitter
    end

### Required modules

Your emitter must define some modules under `lib/my_emitter/`, they are:
* `lib/my_emitter/impact_model.rb` - `module MyEmitter::ImpactModel` - defines the [Leap](http://rubygems.org/gems/leap) decisions that calculate an impact.
* `lib/my_emitter/characterization.rb` - `module MyEmitter::Characterization` - defines the [Characteristics](http://rubygems.org/gems/charisma) that describe the model's inputs.
* `lib/my_emitter/data.rb` - `module MyEmitter::Data` - defines the (schema)[http://rubygems.org/gems/mini\_record] definitions for the emitter and [DataMiner](http://rubygems.org/gems/data\_miner) processes that fetch and store data for the emitter.
* `lib/my_emitter/relationships.rb` - `module MyEmitter::Relationships` - defines the ActiveRecord relationships between the emitter and other [Earth](http://rubygems.org/gems/earth) models.
* `lib/my_emitter/summarization.rb` - `moduel MyEmitter::Summarization` - defines phrases that describe various attributes ([SummaryJudgement descriptors](http://rubygems.org/gems/summary\_judgement))about an emitter that are displayed on CM1's methodology pages.

## Tools

You can use the [bp gem](http://github.com/brighterplanet/bp) to generate the skeleton for a new emitter.

## Note on Patches/Pull Requests
 
* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

== Copyright

Copyright 2010, 2011 Brighter Planet, Inc. See LICENSE and LICENSE-PREAMBLE for details.
