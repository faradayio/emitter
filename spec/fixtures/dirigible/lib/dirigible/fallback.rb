module BrighterPlanet
  module Dirigible
    module Fallback
      def self.included(base)
        base.falls_back_on :distance     => 100
      end
    end
  end
end
