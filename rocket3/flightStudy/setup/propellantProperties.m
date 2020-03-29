function [oxidizerDensity, oxidizerVaporPressure, fuelDensity] = propellantProperties()
    oxidizerDensity = 770; % Density of liquid nitrous oxide
    oxidizerVaporPressure = 5e6; % vapor pressure of nitrous oxide, assuming some temp
    
    fuelDensity = 900; % Density of paraffin
end