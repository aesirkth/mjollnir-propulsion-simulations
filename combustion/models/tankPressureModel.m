function pressure = tankPressureModel(t,oxidizerMass,opts)
  factor = max(1 - opts.OxidizerTankPressureDrop*(1-oxidizerMass/opts.OxidizerMass), 1 - opts.OxidizerTankPressureDrop);
  pressure = opts.OxidizerPressure * factor;
end