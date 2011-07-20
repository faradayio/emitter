module BrighterPlanet
  module Biplane
    module Data
      def self.included(base)
        base.force_schema do
          float :distance
          float :payload
          integer :dirigible_class_id
        end
      end
    end
  end
end
