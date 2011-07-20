require 'active_support'
require 'active_support/core_ext'
require 'leap'
require 'cohort_scope'
require 'charisma'
require 'data_miner'
require 'summary_judgement'
require 'falls_back_on'
require 'force_schema'

require 'emitter/measurement'

module BrighterPlanet
  module Emitter
    REQUIRED_COMPONENTS = %w{
      carbon_model
      characterization
      data
      relationships
      summarization
    }
    
    # "included" not "self.included"
    # why?
    # This module **extends other modules**
    # it forcibly (over)writes their definitions of self.included
    # BrighterPlanet::AutomobileTrip.extend(Emitter) -> now BrighterPlanet::AutomobileTrip has self.included
    # MyAutomobileTrip.include(BrighterPlanet::AutomobileTrip) -> will call BrighterPlanet::AutomobileTrip.included(MyAutomobileTrip)
    def included(base)
      base.extend ClassMethods

      # here self is the emitter module
      common_name = self.name.demodulize.underscore
      common_camel = common_name.camelcase

      REQUIRED_COMPONENTS.each do |component|
        require "#{common_name}/#{component}"
      end
      
      base.instance_variable_set :@emission_scope, @emission_scope if @emission_scope
      
      base.extend ::Leap::Subject
      base.send :include, "::BrighterPlanet::#{common_camel}::CarbonModel".constantize

      base.send :include, ::Charisma
      base.send :include, "::BrighterPlanet::#{common_camel}::Characterization".constantize
      base.class_eval do
        preexisting = characterization.keys
        decisions[:emission].committees.reject do |committee|
          committee.name == :emission or preexisting.include?(committee.name)
        end.each do |committee|
          characterize do
            has committee.name, :options => committee.options.slice(:measures, :display_with)
          end
        end
      end

      base.send :include, "::BrighterPlanet::#{common_camel}::Data".constantize
      unless base.data_miner_config.steps.any? { |step| step.description == :force_schema! }
        base.data_miner_config.steps.unshift ::DataMiner::Process.new(base.data_miner_config, :force_schema!)
      end
      unless base.data_miner_config.steps.any? { |step| step.description == :run_data_miner_on_parent_associations! }
        base.data_miner_config.steps.push ::DataMiner::Process.new(base.data_miner_config, :run_data_miner_on_parent_associations!)
      end

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

    # this gets added as a class method to the emitter module
    def scope(statement)
      @emission_scope = statement
    end
        
    module ClassMethods
      # this will have been set by self.included on the emitter module
      def emission_scope
        @emission_scope
      end
    end
  end
end
