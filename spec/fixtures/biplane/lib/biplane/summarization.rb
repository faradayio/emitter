require 'summary_judgement'

module BrighterPlanet
  module Biplane
    module Summarization
      def self.included(base)
        base.extend SummaryJudgement
        base.summarize do |has|
          has.identity 'dirigible'
        end
      end
    end
  end
end
