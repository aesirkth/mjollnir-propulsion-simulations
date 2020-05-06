function [regressionRate,ccPressureVariation,oxidizerMassFlow,fuelMassFlow,cStar,ccTemperature, tankPressure] = combustionModel(t,portRadius,ccPressure,oxidizerMass,opts)
if oxidizerMass > 0
    
    % Tank pressure of the instant
    tankPressure = tankPressureModel(t,oxidizerMass,opts);
    
    % Propellant mass flow and regression rate
    ox.h_l = py.CoolProp.CoolProp.PropsSI('H','P',tankPressure,'Q',0,'N2O'); % specific enthalpy of N2O state in tank
    oxidizerMassFlow = oxidizerMassFlowModel(tankPressure,ccPressure,ox.h_l,opts);
    regressionRate = regressionRateModel(portRadius,oxidizerMassFlow);
    fuelMassFlow = fuelMassFlowModel(regressionRate,portRadius,opts);

    % Characteristic velocity (from curve)
    cStar = characteristicVelocity(oxidizerMassFlow,fuelMassFlow);
    
    k = opts.Gamma;
    
    R = 8.314 / opts.ProductsMolecularWeight;
    ccTemperature = cStar^2 * k / R * (2/(k+1))^((k+1)/(k-1));
    
    % Nozzle mass flow
    nozzleMassFlow = nozzleMassFlowModel(ccPressure,cStar,opts);
    
    % difference between income and outcome mass flows
    diffMassFlow = fuelMassFlow+oxidizerMassFlow-nozzleMassFlow;
    
    % Pressure variation from mass variation in the chamber
    V1 = pi * portRadius^2 * opts.FuelGrainLength;
    dRho1 = diffMassFlow / V1;
    ccPressureVariation = (8.314 / opts.ProductsMolecularWeight) * ccTemperature * dRho1;
    
else
    tankPressure = tankPressureModel(t,0,opts);
    ccPressureVariation = 0;
    oxidizerMassFlow = 0;
    regressionRate = 0;
    fuelMassFlow = 0;
    cStar = 0;
    ccTemperature = 0;
end