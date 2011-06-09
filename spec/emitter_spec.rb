require 'spec_helper'

describe BrighterPlanet::Emitter do
  describe '.included' do
    before :all do
      require 'active_record'
      class Aircraft < ActiveRecord::Base; end
      class Airship < ActiveRecord::Base; end

      $:.unshift File.expand_path('fixtures/dirigible/lib', File.dirname(__FILE__))
      require 'dirigible'
      Airship.send :include, BrighterPlanet::Dirigible
      Airship.create_table!

      $:.unshift File.expand_path('fixtures/biplane/lib', File.dirname(__FILE__))
    end

    it 'should include fallback if available' do
      Airship.new.kind_of?(BrighterPlanet::Dirigible::Fallback).
        should be_true
    end

    it 'should include relationships if available' do
      Airship.new.kind_of?(BrighterPlanet::Dirigible::Relationships).
        should be_true
    end

    it 'should not include fallback or relationships if there are none' do
      expect do
        require 'biplane'
        Aircraft.send :include, BrighterPlanet::Biplane
      end.should_not raise_error
    end
    
    it 'should state its own scope' do
      Airship.emission_scope.should == 'Anthropogenic emissions resulting from the inflation, launching, and acceleration of dirigibles'
    end
    
    it 'should have extra data_miner steps' do
      Airship.data_miner_config.steps[0].description.should == :create_table!
      Airship.data_miner_config.steps[1].description.should == :run_data_miner_on_parent_associations!
      Airship.data_miner_config.steps[2].description.should == "the first step defined in the emitter module"
    end
  end
end

