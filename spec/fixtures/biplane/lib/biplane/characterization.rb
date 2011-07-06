module BrighterPlanet
  module Biplane
    module Characterization
      def self.included(base)
        base.characterize do
          has :distance, :measures => :length
          has :payload, :measures => :mass
          has :dirigible_class
        end
      end
    end
  end
end
