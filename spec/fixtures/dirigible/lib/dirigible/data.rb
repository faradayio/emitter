require 'data_miner'

module BrighterPlanet
  module Dirigible
    module Data
      def self.included(base)
        base.data_miner do
          schema do
            float :distance
            float :payload
            integer :dirigible_class_id
          end

          process :run_data_miner_on_belongs_to_associations
        end
      end
    end
  end
end
