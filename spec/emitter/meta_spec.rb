require 'spec_helper'

class Automobile; extend BrighterPlanet::Emitter::Meta; end
class Flight; extend BrighterPlanet::Emitter::Meta; end

describe BrighterPlanet::Emitter::Meta do
  describe '.beta?' do
    it 'should return true for an emitter that is in beta' do
      BrighterPlanet::Emitter::BETA_LIST = ['flight']
      Flight.should be_beta
    end
    it 'should return false for an emitter that is not in beta' do
      Automobile.should_not be_beta
    end
  end
end

