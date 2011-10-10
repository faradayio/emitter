module BrighterPlanet
  module Biplane
    module Data
      def self.included(base)
        base.col :distance, :type => :float
        base.col :payload, :type => :float
        base.col :dirigible_class_id, :type => :integer
      end
    end
  end
end
