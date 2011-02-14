require 'emitter'

module BrighterPlanet
  module Dirigible
    extend BrighterPlanet::Emitter
    
    def self.included(base)
      super
      base.emission_scope 'Anthropogenic emissions resulting from the inflation, launching, and acceleration of dirigibles'
    end
  end
end
