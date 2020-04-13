function [dX,combustionChamberPressure,oxidizerMassFlow,regressionRate,fuelMassFlow] = solveCombustion(t,X,opts)
portRadius = X(1);
tankPressure = tankPressureModel(t,opts);
combustionChamberPressure = combustionChamberPressureModel(portRadius,tankPressure,opts);
oxidizerMassFlow = oxidizerMassFlowModel(tankPressure,combustionChamberPressure,opts);
regressionRate = regressionRateModel(portRadius,oxidizerMassFlow);
fuelMassFlow = fuelMassFlowModel(regressionRate,portRadius,opts);
dX = regressionRate;
end