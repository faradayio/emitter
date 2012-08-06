require 'emitter'

require_relative 'dirigible/impact_model'
require_relative 'dirigible/characterization'
require_relative 'dirigible/data'
require_relative 'dirigible/relationships'
require_relative 'dirigible/summarization'

module BrighterPlanet
  module Dirigible
    extend BrighterPlanet::Emitter
    scope 'Anthropogenic impacts resulting from the inflation, launching, and acceleration of dirigibles'
  end
end
