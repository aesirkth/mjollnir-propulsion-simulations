function massFlow = nozzleMassFlowModel(combustionChamberPressure,opts)
massFlow = combustionChamberPressure * opts.nozzleThroatArea * ...
    sqrt(opts.gamma / opts.specificR / opts.combustionChamberTemp * (2/(opts.gamma+1))^((opts.gamma+1)/(opts.gamma-1)));
end