% Material properties from: https://www.nedal.com/wp-content/uploads/2016/11/Nedal-alloy-Datasheet-EN-AW-6082.pdf
ofRatio = 4;

opts.OxidizerDensity = 1230;            % Liquid N2O density at boiling point
opts.OxidizerTankPressure = 5e6;        % Initial tank pressure
opts.OxidizerTankDiameter = 0.075;
opts.OxidizerTankDensity  = 2700;
opts.OxidizerTankSigma  = 290*10^6/2;   % allowable stress: half of transile strength (assumption)
opts.OxidizerTankSafetyMargin = 1.5;

