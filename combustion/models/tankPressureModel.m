function pressure = tankPressureModel(t,oxidizerMass,opts)
pressure = opts.OxidizerTankPressure * max(1 - 0.2*(1-oxidizerMass/opts.OxidizerMass),0.8);
end