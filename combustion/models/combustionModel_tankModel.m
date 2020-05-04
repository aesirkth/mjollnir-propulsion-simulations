function [regressionRate,ccPressureVariation,fuelMassFlow,cStar,ccTemperature] = combustionModel_tankModel(t,portRadius,ccPressure,oxidizerMass, oxidizerMassFlow,opts)
if oxidizerMass > 0
    
    regressionRate = regressionRateModel(portRadius,oxidizerMassFlow);
    fuelMassFlow = fuelMassFlowModel(regressionRate,portRadius,opts);
    
    % Characteristic velocity (from curve)
    cStar = characteristicVelocity(oxidizerMassFlow,fuelMassFlow);
    ccTemperature = cStar^2 * opts.Gamma * ((opts.Gamma+1)/2)^(-(opts.Gamma+1)/(opts.Gamma-1)) * opts.ProductsMolecularWeight / 8.314;
    
    % Nozzle mass flow
    nozzleMassFlow = nozzleMassFlowModel(ccPressure,cStar,opts);
    
    % difference between income and outcome mass flows
    diffMassFlow = fuelMassFlow+oxidizerMassFlow-nozzleMassFlow;
    
    % Pressure variation from mass variation in the chamber
    V1 = pi * portRadius^2 * opts.FuelGrainLength;
    dRho1 = diffMassFlow / V1;
    ccPressureVariation = (8.314 / opts.ProductsMolecularWeight) * ccTemperature * dRho1;
    
else
    ccPressureVariation = 0;
    regressionRate = 0;
    fuelMassFlow = 0;
    cStar = 0;
    ccTemperature = 0;
end