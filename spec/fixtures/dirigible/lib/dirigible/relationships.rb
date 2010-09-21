module BrighterPlanet
  module Dirigible
    module Relationships
      def self.included(base)
        base.belongs_to :dirigible_class
      end
    end
  end
end
