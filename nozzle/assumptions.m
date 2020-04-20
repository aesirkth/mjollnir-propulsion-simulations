opts.NozzleThroatDiameter = 0.03;
opts.NozzleExhaustDiameter = 0.1;
expansionPressureInAtmospheres = 1; % The pressure which the nozzle expands exhaust to

opts.NozzleExhaustArea = opts.NozzleExhaustDiameter^2/4*pi;
opts.NozzleThroatArea = opts.NozzleThroatDiameter^2/4*pi;

opts.ExpansionPressure = expansionPressureInAtmospheres * 101300;