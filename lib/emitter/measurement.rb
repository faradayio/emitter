# encoding: UTF-8

# defined by charisma:
# length kilometres (see below)
# mass kilograms
# speed metres_per_second (see below)
# time seconds

module BrighterPlanet
  module Measurement
    class Area < ::Charisma::Measurement
      units :square_metres => 'm²'
    end
    
    class Biomass < ::Charisma::Measurement
      units :joules => 'J'
    end
    
    class Cost < ::Charisma::Measurement
      units :dollars => 'USD'
    end

    class ElectricalEnergy < ::Charisma::Measurement
      units :kilowatt_hours => 'kWh'
    end
    
    class Volume < ::Charisma::Measurement
      units :litres => 'l'
    end
    
    # TODO use charisma default
    class BigLength < ::Charisma::Measurement
      units :kilometres => 'km'
    end

    # TODO units :metres_per_litre => 'm/l'
    class BigLengthPerVolume < ::Charisma::Measurement
      units :kilometres_per_litre => 'km/l'
    end
    
    # TODO use charisma default
    class BigSpeed < ::Charisma::Measurement
      units :kilometres_per_hour => 'km/h'
    end
  end
end
