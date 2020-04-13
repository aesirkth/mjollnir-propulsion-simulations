function pressure = tankPressureModel(t,opts)
pressure = opts.initialTankPressure * max(1 - 0.2*t/opts.burnTime,0.8);
end