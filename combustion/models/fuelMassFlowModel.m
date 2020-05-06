function massFlow = fuelMassFlowModel(regressionRate,portRadius,opts)
Rinit = opts.FuelGrainInitialPortRadius;
a = opts.CombustionChamberSinusShapeAmplitude;
C8 = opts.CombustionChamberInitialPerimeter;
coeff = 1+(C8/(2*pi*Rinit) - 1)*exp(sqrt(6/a)*(Rinit-portRadius)*2/Rinit);
massFlow = (opts.FuelGrainDensity * regressionRate * 2 * pi * portRadius * opts.FuelGrainLength)*coeff;
end