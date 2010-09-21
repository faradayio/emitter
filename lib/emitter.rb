module BrighterPlanet
  module Emitter
    def included(base)
      base.extend ClassMethods
      
      emitter_klass = self.to_s.split('::').last.underscore

      %w{carbon_model characterization data fallback relationships summarization}.each do |component|
        begin
          require "#{emitter_klass}/#{component}"
        rescue LoadError
        end
      end

      require 'leap'
      require 'cohort_scope'
      base.extend Leap::Subject
      base.send :include, const_get('CarbonModel')

      require 'characterizable'
      base.send :include, Characterizable
      base.send :include, const_get('Characterization')
      base.add_implicit_characteristics

      require 'data_miner'
      base.send :include, const_get('Data')

      if const_defined?('Fallback')
        require 'falls_back_on'
        require 'falls_back_on/active_record_ext'
        base.send :include, const_get('Fallback') 
      end

      if const_defined?('Relationships')
        base.send :include, const_get('Relationships')
      end

      require 'summary_judgement'
      base.extend SummaryJudgement
      base.send :include, const_get('Summarization')
    end
    
    module ClassMethods
      def add_implicit_characteristics
        decisions[:emission].committees.map(&:name).reject { |c| characteristics.keys.unshift(:emission).include? c }.each do |c|
          characterize { has c }
        end
      end
    end
  end
end
