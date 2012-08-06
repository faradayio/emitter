require 'emitter'

require_relative 'biplane/impact_model'
require_relative 'biplane/characterization'
require_relative 'biplane/data'
require_relative 'biplane/relationships'
require_relative 'biplane/summarization'

module BrighterPlanet
  module Biplane
    extend BrighterPlanet::Emitter
  end
end
