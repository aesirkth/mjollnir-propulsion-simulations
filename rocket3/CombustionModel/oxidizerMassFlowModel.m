function massFlow = oxidizerMassFlowModel(tankPressure,combustionChamberPressure,opts)
if combustionChamberPressure < tankPressure
    massFlow = opts.injectorsCd * opts.injectorsArea * sqrt(2* opts.oxidizerDensity * (tankPressure - combustionChamberPressure));
else
    massFlow = 0;
end
end