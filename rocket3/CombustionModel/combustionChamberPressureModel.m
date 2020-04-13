function combustionChamberPressure = combustionChamberPressureModel(portRadius,tankPressure,opts)
    func = @(p1) combustionPressureSolve(p1,portRadius,tankPressure,opts);
    combustionChamberPressure = fzero(func,0);
    function diffMassFlow = combustionPressureSolve(combustionChamberPressure,portRadius,tankPressure,opts)
        oxidizerMassFlow = oxidizerMassFlowModel(tankPressure,combustionChamberPressure,opts);
        regressionRate = regressionRateModel(portRadius,oxidizerMassFlow);
        fuelMassFlow = fuelMassFlowModel(regressionRate,portRadius,opts);
        nozzleMassFlow = nozzleMassFlowModel(combustionChamberPressure,opts);
        diffMassFlow = fuelMassFlow+oxidizerMassFlow-nozzleMassFlow;
end
end