require 'leap'
require 'cohort_scope'
require 'charisma'
require 'data_miner'
require 'summary_judgement'
require 'falls_back_on'

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
      
      base.extend ::Leap::Subject
      base.send :include, "::BrighterPlanet::#{common_camel}::CarbonModel".constantize

      base.send :include, ::Charisma
      base.send :include, "::BrighterPlanet::#{common_camel}::Characterization".constantize
      base.characterize do
        has :emission, :options => { :measures => CarbonEmission }
      end        
      base._add_implicit_characteristics

      base.send :include, "::BrighterPlanet::#{common_camel}::Data".constantize

      base.extend ::SummaryJudgement
      base.send :include, "::BrighterPlanet::#{common_camel}::Summarization".constantize

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
    
    class CarbonEmission < ::Charisma::Measurement
      units :kilograms => 'kg CO2e'
    end
    
    module ClassMethods
      def _add_implicit_characteristics
        preexisting = characteristics.keys
        decisions[:emission].committees.reject do |committee|
          preexisting.include? committee.name
        end.each do |committee|
          characterize do
            has committee.name, :options => committee.options.slice(:measures, :display_with)
          end
        end
      end
            
      def emission_scope; @emission_scope end
    end
  end
end
