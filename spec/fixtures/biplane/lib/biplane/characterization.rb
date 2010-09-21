require 'characterizable'

module BrighterPlanet
  module Biplane
    module Characterization
      def self.included(base)
        base.characterize do
          has :distance
          has :payload
          has :dirigible_class
        end
        base.add_implicit_characteristics
      end
    end
  end
end
