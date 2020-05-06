% The simulation system
function [dXcc_dt,regressionRate,ccPressureVariation,fuelMassFlow,thrust,ccTemperature] = combustionOdeSystem_tankModel(t, Xtank, Xcc, oxidizerMassFlow, opts)
    % X is of the form [fuelMass, portRadius, ccPressure(, oxidizerMass)]
    fuelMass = Xcc(1);
    portRadius = Xcc(2);
    ccPressure = Xcc(3);
    
    oxidizerMass = Xtank(4);
    
    % Combustion model
    [regressionRate,ccPressureVariation,fuelMassFlow,cStar,ccTemperature] = combustionModel_tankModel(t,portRadius, ccPressure, oxidizerMass, oxidizerMassFlow, opts);

    % Computed mass flow
    massFlow = oxidizerMassFlow + fuelMassFlow;

    % Thrust Force
    if opts.extraOutput == 1
        thrust = thrustModel(t, massFlow, ccPressure, opts.AmbientPressure, cStar, opts);
    else
        thrust = 0;
    end
    % Returning differential vector
    dXcc_dt = [-fuelMassFlow;regressionRate;ccPressureVariation];    

end

