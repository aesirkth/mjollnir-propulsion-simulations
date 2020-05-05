% The simulation system
function [dXdt,regressionRate,ccPressureVariation,oxidizerMassFlow,fuelMassFlow,thrust,ccTemperature, tankPressure] = combustionOdeSystem(t, X, opts)
    % X is of the form [fuelMass, portRadius, ccPressure, oxidizerMass]
    fuelMass = X(1);
    portRadius = X(2);
    ccPressure = X(3);
    oxidizerMass = X(4);

    % Combustion model
    [regressionRate,ccPressureVariation,oxidizerMassFlow,fuelMassFlow,cStar,ccTemperature, tankPressure] = combustionModel(t,portRadius, ccPressure, oxidizerMass, opts);

    % Computed mass flow
    massFlow = oxidizerMassFlow + fuelMassFlow;

    % Thrust Force
    if opts.extraOutput ~= 0
        thrust = thrustModel(t, massFlow, ccPressure, opts.AmbientPressure, cStar, opts);
    else
        thrust = 0;
    end
    
    % Returning differential vector
    dXdt = [-fuelMassFlow;regressionRate;ccPressureVariation;-oxidizerMassFlow];
end

