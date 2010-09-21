module BrighterPlanet
  module Dirigible
    module Summarization
      def self.included(base)
        base.summarize do |has|
          has.identity 'dirigible'
        end
      end
    end
  end
end
