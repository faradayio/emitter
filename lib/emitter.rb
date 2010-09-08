require 'cohort_scope'
require 'falls_back_on'
require 'falls_back_on/active_record_ext'
# sabshere 8/15/10 why aren't these required here?
# require 'characterizable'
# require 'leap'
# require 'weighted_average'

module BrighterPlanet
  module Emitter
    def included(base)
      base.extend ClassMethods
      
      emitter_klass = self.to_s.split('::').last.underscore

      require "#{emitter_klass}/carbon_model"
      require "#{emitter_klass}/characterization"
      require "#{emitter_klass}/data"
      require "#{emitter_klass}/summarization"

      base.send :include, const_get('CarbonModel')
      base.send :include, const_get('Characterization')
      base.send :include, const_get('Data')
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
