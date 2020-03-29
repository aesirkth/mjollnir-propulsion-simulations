% set necessary assumptions
propellantMass = 32;    

% Parachute: 10 kg
% Electronics: 2.3 kg
% Body tube: 7 kg
% Misc: 2 kg
parachuteMass = 10;
electronicsMass = 2.3;
bodyTubeMass = 7;
payloadMass = 2;

rocketDiameterInCentimeters = 15;
fuelGrainDiameterInCentimeters = 15;
diameterOfNozzleExhaustInCentimeters = 8;
specificImpulse = 150;
launchAngle = 87;

tankPressure = 5e6; % Nitrous vapor pressure
combustionPressure = 4.5e6;

expansionPressureInAtmospheres = 1; % The pressure which the nozzle expands exhaust to

ofRatio = 4;