module BrighterPlanet
  module Emitter
    REQUIRED_COMPONENTS = %w{
      carbon_model
      characterization
      data summarization
      relationships
    }
    def included(base)
      base.extend ClassMethods
      
      common_name = self.to_s.split('::').last.underscore
      common_camel = common_name.camelcase

      REQUIRED_COMPONENTS.each do |component|
        require "#{common_name}/#{component}"
      end
      
      base.instance_variable_set :@emission_scope, @emission_scope if @emission_scope
      
      require 'leap'
      require 'cohort_scope'
      base.extend ::Leap::Subject
      base.send :include, "::BrighterPlanet::#{common_camel}::CarbonModel".constantize

      require 'charisma'
      base.send :include, ::Charisma
      base.send :include, "::BrighterPlanet::#{common_camel}::Characterization".constantize

      require 'data_miner'
      base.send :include, "::BrighterPlanet::#{common_camel}::Data".constantize

      require 'summary_judgement'
      base.extend ::SummaryJudgement
      base.send :include, "::BrighterPlanet::#{common_camel}::Summarization".constantize

      require 'falls_back_on'
      begin
        require "#{common_name}/fallback"
        base.send :include, "::BrighterPlanet::#{common_camel}::Fallback".constantize
      rescue ::LoadError
        # not required
      end

      base.send :include, "::BrighterPlanet::#{common_camel}::Relationships".constantize
    end
        
    def scope(statement)
      @emission_scope = statement
    end
    
    module ClassMethods
      def emission_scope; @emission_scope end
    end
  end
end
