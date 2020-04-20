opts.NozzleThroatDiameter = opts.NozzleThroatDiameterInCm / 100;
opts.NozzleExhaustDiameter = opts.NozzleExhaustDiameterInCm / 100;

opts.NozzleExhaustArea = (opts.NozzleExhaustDiameter / 2)^2 * pi;
opts.NozzleThroatArea = (opts.NozzleThroatDiameter / 2)^2 * pi;

opts.NozzleExpansionPressure = opts.NozzleExpansionPressureInAtmospheres * 101300;