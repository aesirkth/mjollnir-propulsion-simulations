% Material properties from: https://www.nedal.com/wp-content/uploads/2016/11/Nedal-alloy-Datasheet-EN-AW-6082.pdf
ofRatio = 4;

opts.OxidizerDensity = 770;
opts.OxidizerTankPressure = 5e6;
opts.OxidizerTankDiameter = 0.075;
opts.OxidizerTankDensity  = 2700;
opts.OxidizerTankSigma  = 290*10^6/2;   % allowable stress: half of transile strength (assumption)
opts.OxidizerTankSafetyMargin = 1.5;
opts.FuelDensity = 900;
opts.ccCombustionPressure = 4.5e6;
opts.ccDiameter = 0.075;
opts.ccDensity  = 2700;
opts.ccSigma  = 290*10^6/2;             % allowable stress: half of transile strength (assumption)
opts.ccSafetyMargin = 1.5;