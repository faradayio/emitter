module BrighterPlanet
  module Emitter
    def included(base)
      emitter_klass = self.to_s.split('::').last

      require 'cohort_scope'
      require 'falls_back_on'
      require 'falls_back_on/active_record_ext'

      require "#{emitter_klass.underscore}/carbon_model"
      require "#{emitter_klass.underscore}/characterization"
      require "#{emitter_klass.underscore}/data"
      require "#{emitter_klass.underscore}/summarization"

      base.send :include, const_get('CarbonModel')
      base.send :include, const_get('Characterization')
      base.send :include, const_get('Data')
      base.send :include, const_get('Summarization')
    end
  end
end
