% Parachute: 10 kg
% Electronics: 2.3 kg
% Body tube: 7 kg
% Misc: 2 kg
parachuteMass = 10;
electronicsMass = 2.3;
bodyTubeMass = 7;
payloadMass = 2;

rocketDiameterInCentimeters = 15;

ofRatio = 8;

massFlow = 2.5; % Total mass flow of usable propellant


% layers from the outside to inside, in millimeters
fiberGlass = 0;
empty = 0;
aluminium = 3;
cardboard = 1;
margin = 8;

totalMargin = fiberGlass + empty  + aluminium + cardboard + margin;
usableSpace = 150 - 2*(totalMargin);

combustionChamberDiameterCm = 15;
fuelGrainLengthCm = 44;
fuelGrainMarginThicknessMm = totalMargin;
fuelGrainCenterPortDiameterCm = 5;

diameterOfNozzleExhaustInCentimeters = 8;
specificImpulse = 150;
launchAngle = 87;

tankPressure = 5e6; % Nitrous vapor pressure
combustionPressure = 4.5e6;

expansionPressureInAtmospheres = 1; % The pressure which the nozzle expands exhaust to
