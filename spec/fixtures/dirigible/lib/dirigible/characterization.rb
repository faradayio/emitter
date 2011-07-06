module BrighterPlanet
  module Dirigible
    module Characterization
      def self.included(base)
        base.characterize do
          has :distance, :measures => :length
          has :payload, :measures => :mass
          has :surface_area, :measures => Measurement::Area
          has :dirigible_class
        end
      end
    end
  end
end
