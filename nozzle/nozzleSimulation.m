function nozzleState = nozzleSimulation(opts)
  run("./nozzle/derivedProperties");

  nozzleState = struct();
  nozzleState.opts = opts;
  nozzleState.NozzleThroatDiameter = opts.NozzleThroatDiameter;
  nozzleState.NozzleExhaustDiameter = opts.NozzleExhaustDiameter;
  nozzleState.NozzleExhaustArea = opts.NozzleExhaustArea;
  nozzleState.NozzleThroatArea = opts.NozzleThroatArea;
  nozzleState.NozzleExpansionPressure = opts.NozzleExpansionPressure;

  nozzleState.NozzleEfficiency = opts.NozzleEfficiency;
end