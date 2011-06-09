module BrighterPlanet
  module Biplane
    module Data
      def self.included(base)
        base.create_table do
          float :distance
          float :payload
          integer :dirigible_class_id
        end
      end
    end
  end
end
