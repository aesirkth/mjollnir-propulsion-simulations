function massFlow = fuelMassFlowModel(regressionRate,portRadius,opts)
massFlow = opts.FuelDensity * regressionRate * 2 * pi * portRadius * opts.PortLength;
end