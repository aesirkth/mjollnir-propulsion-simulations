function [oxidizerDensity, oxidizerVaporPressure, fuelDensity, carbonAdditiveDensity] = propellantProperties()
    oxidizerDensity = 1230; % Density of liquid nitrous oxide
    oxidizerVaporPressure = 5e6; % vapor pressure of nitrous oxide, assuming some temp

    fuelDensity = 900; % Density of paraffin
    carbonAdditiveDensity = 1800;
end