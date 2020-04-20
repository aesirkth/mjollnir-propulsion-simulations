function massFlow = oxidizerMassFlowModel(tankPressure,combustionChamberPressure,opts)
if combustionChamberPressure < tankPressure
    massFlow = opts.InjectorsCd * opts.InjectorsArea * sqrt(2* opts.OxidizerDensity * (tankPressure - combustionChamberPressure));
else
    massFlow = 0;
end
end