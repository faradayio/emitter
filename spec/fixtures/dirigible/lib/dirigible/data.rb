module BrighterPlanet
  module Dirigible
    module Data
      def self.included(base)
        base.col :distance, :type => :float
        base.col :payload, :type => :float
        base.col :surface_area, :type => :float
        base.col :dirigible_class_id, :type => :integer
        
        base.data_miner do
          process "the first step defined in the emitter module" do
            # just make sure i'm here
          end
        end
      end
    end
  end
end
