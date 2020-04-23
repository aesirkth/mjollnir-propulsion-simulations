% This file is run in flightSimulation.m
% Do not run this file as it is.
%
% This file contains assumptions for the flight simulation of the Eyjafjallajökull hybrid rocket engine.

% Parachute: 10 kg
% Electronics: 2.3 kg
% Body tube: 7 kg
% Misc: 2 kg
opts.parachuteMass = 10;
opts.electronicsMass = 2.3;
opts.bodyTubeMass = 7;
opts.payloadMass = 2;

opts.LaunchAngle = 85;

opts.goalAltitude = 12; % We want to reach this
opts.excessiveGoalAltitude = 14; % So we aim for this

opts.launchRailLength = 12; % Used to direct the velocity vector