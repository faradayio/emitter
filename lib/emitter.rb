module BrighterPlanet
  module Emitter
    LIST = %w{
      automobile
      automobile_trip
      bus_trip
      computation
      diet
      electricity_use
      flight
      fuel_purchase
      lodging
      meeting
      motorcycle
      pet
      purchase
      rail_trip
      residence
      shipment
    }
    BETA_LIST = %w{}
    REQUIRED_COMPONENTS = %w{
      carbon_model
      characterization
      data summarization
      fallback
      relationships
    }
    def included(base)
      base.extend Meta
      base.extend ClassMethods
      
#      base.instance_variable_set :@emission_scope, nil
      
      common_name = self.to_s.split('::').last.underscore
      common_camel = common_name.camelcase

      REQUIRED_COMPONENTS.each do |component|
        require "#{common_name}/#{component}"
      end
      
      require 'leap'
      require 'cohort_scope'
      base.extend ::Leap::Subject
      base.send :include, "::BrighterPlanet::#{common_camel}::CarbonModel".constantize

      require 'characterizable'
      base.send :include, ::Characterizable
      base.send :include, "::BrighterPlanet::#{common_camel}::Characterization".constantize
      base.add_implicit_characteristics

      require 'data_miner'
      base.send :include, "::BrighterPlanet::#{common_camel}::Data".constantize

      require 'summary_judgement'
      base.extend ::SummaryJudgement
      base.send :include, "::BrighterPlanet::#{common_camel}::Summarization".constantize

      require 'falls_back_on'
      require 'falls_back_on/active_record_ext'
      base.send :include, "::BrighterPlanet::#{common_camel}::Fallback".constantize

      base.send :include, "::BrighterPlanet::#{common_camel}::Relationships".constantize
    end
    
    def self.classes
      LIST.map(&:camelize).map(&:constantize)
    end
    
    module ClassMethods
      def add_implicit_characteristics
        decisions[:emission].committees.map(&:name).reject { |c| characteristics.keys.unshift(:emission).include? c }.each do |c|
          characterize { has c }
        end
      end
      
#      def emission_scope(statement = nil)
#        if statement == false
#          @emission_scope = nil
#        elsif statement
#          @emission_scope = statement
#        else
#         @emission_scope
#        end
#      end
    end

    module Meta
      def beta?
        BETA_LIST.include?(self.to_s.underscore)
      end
    end
  end
end
