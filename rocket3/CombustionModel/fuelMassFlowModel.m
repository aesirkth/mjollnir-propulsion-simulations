function massFlow = fuelMassFlowModel(regressionRate,portRadius,opts)
massFlow = opts.fuelDensity * regressionRate * 2 * pi * portRadius * opts.portLength;
end