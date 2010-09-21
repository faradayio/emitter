require 'leap'

module BrighterPlanet
  module Dirigible
    module CarbonModel
      def self.included(base)
        base.decide :emission, :with => :characteristics do
          committee :emission do # returns kg CO2e
            quorum 'default' do
              100.0
            end
          end
        end
      end
    end
  end
end
