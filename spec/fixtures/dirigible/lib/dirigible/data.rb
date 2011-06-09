module BrighterPlanet
  module Dirigible
    module Data
      def self.included(base)
        base.create_table do
          float :distance
          float :payload
          integer :dirigible_class_id
        end
        
        base.data_miner do
          process "the first step defined in the emitter module" do
            # just make sure i'm here
          end
        end
      end
    end
  end
end
