module BrighterPlanet
  module Emitter
    LIST = %w{automobile automobile_trip bus_trip computation diet flight fuel_purchase lodging meeting motorcycle pet purchase rail_trip residence}
    BETA_LIST = %w{}

    REQUIRED_COMPONENTS = %w{carbon_model characterization data summarization}
    OPTIONAL_COMPONENTS = %w{fallback relationships}
    def included(base)
      base.extend Meta
      base.extend ClassMethods
      
      common_name = self.to_s.split('::').last.underscore
      common_camel = common_name.camelcase

      REQUIRED_COMPONENTS.each do |component|
        require "#{common_name}/#{component}"
      end
      
      extra = []
      OPTIONAL_COMPONENTS.each do |component|
        begin
          require "#{common_name}/#{component}"
          extra << component
        rescue LoadError
          # Oh well, we shouldn't need it.
        end
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

      if extra.include? 'fallback'
        require 'falls_back_on'
        require 'falls_back_on/active_record_ext'
        base.send :include, "::BrighterPlanet::#{common_camel}::Fallback".constantize
      end

      if extra.include? 'relationships'
        base.send :include, "::BrighterPlanet::#{common_camel}::Relationships".constantize
      end
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
    end

    module Meta
      def beta?
        BETA_LIST.include?(self.to_s.underscore)
      end
    end
  end
end
