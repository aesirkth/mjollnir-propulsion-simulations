clear
close all

path(pathdef);

addpath('./nozzle');
addpath('./coolprop');
addpath('./combustion');
addpath('./physicalDesign');
addpath('./flight');
addpath('./plotting');

global plotDirectory;
[dir] = fileparts(mfilename('fullpath'));
plotDirectory = fullfile(dir, "/plots");
clear dir;
