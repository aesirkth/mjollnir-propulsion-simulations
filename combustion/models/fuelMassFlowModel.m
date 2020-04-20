function massFlow = fuelMassFlowModel(regressionRate,portRadius,opts)
massFlow = opts.FuelGrainDensity * regressionRate * 2 * pi * portRadius * opts.FuelGrainLength;
end