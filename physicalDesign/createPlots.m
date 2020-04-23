setupSubplots(3,1)

ccWallThickness = 0.01;
casingThickness = 0.01;
unusableMarginThickness = 0.01;
initialPortRadius = 0.01;
fuelGrainLength = 0.3;

rOxidTank = 0.075;
rCC = 0.075;

lOxidTank = 2;
tOxidTank = 0.003;

nextPlot("physicalDesign/fuelGrain");
hold on

offset = 0;
plotCombustionChamber(rCC, ccWallThickness, casingThickness, unusableMarginThickness, initialPortRadius, fuelGrainLength, offset);
setupPlot(rCC, "Combustion chamber");

nextPlot("physicalDesign/oxidizerTank");
hold on
plotOxidizerTank(rOxidTank, lOxidTank, tOxidTank, 0);
setupPlot(rOxidTank, "Oxidizer tank");

nextPlot("physicalDesign/fullAssembly");
hold on

offset = rCC;
plotCombustionChamber(rCC, ccWallThickness, casingThickness, unusableMarginThickness, initialPortRadius, fuelGrainLength, offset);

offset = fuelGrainLength + 4*rCC;
plotOxidizerTank(rOxidTank, lOxidTank, tOxidTank, offset);
setupPlot(max(rOxidTank, rCC), "Full system");

function plotCombustionChamber(radius, wallThickness, fuelGrainCasingThickness, unusableFuelThickness, initialPortRadius, fuelGrainLength, yOffset)
  r = radius; % 
  wor = radius; % Wall outer radius
  wir = radius - wallThickness; % Wall inner radius

  cor = wir; % Casing outer radius
  cir = wir - fuelGrainCasingThickness; % Casing inner radius

  ufor = cir; % Unusable fuel outer radius
  ufir = cir - unusableFuelThickness; % Unusable fuel inner radius

  pfor = ufir; % Usable fuel outer radius
  pfir = initialPortRadius; % Usable fuel inner radius

  L = fuelGrainLength;
  
  fill([wor wir wir wor], [0 0 L L] + yOffset, 'm', 'HandleVisibility', 'off')
  fill(-[wor wir wir wor], [0 0 L L] + yOffset, 'm', 'DisplayName', 'Walls')

  fill([cor cir cir cor], [0 0 L L] + yOffset, 'c', 'HandleVisibility', 'off')
  fill(-[cor cir cir cor], [0 0 L L] + yOffset, 'c', 'DisplayName', 'Fuel grain casing')

  fill([ufor ufir ufir ufor], [0 0 L L] + yOffset, 'r', 'HandleVisibility', 'off')
  fill(-[ufor ufir ufir ufor], [0 0 L L] + yOffset, 'r', 'DisplayName', 'Unusable fuel (margin)')

  fill([pfor pfir pfir pfor], [0 0 L L] + yOffset, 'g', 'HandleVisibility', 'off')
  fill(-[pfor pfir pfir pfor], [0 0 L L] + yOffset, 'g', 'DisplayName', 'Usable fuel')
  axis equal
end

function plotOxidizerTank(radius, length, thickness, yOffset)
  [Xoxidizer, Yoxidizer] = renderFilledCapsuleTank(2*(radius - thickness), length);
  [Xtank, Ytank] = renderCapsuleTank(2*radius, length, thickness);

  fill(Xoxidizer, Yoxidizer+yOffset, [0.3 0.3 0.7], 'DisplayName', 'Oxidizer');
  fill(Xtank, Ytank+yOffset, 'y', 'LineWidth', 0.01, 'DisplayName', 'Oxidizer tank');
end

function setupPlot(r, plottitle)
  title(plottitle);
  axis equal
  lims = ylim;
  ylim([lims(1)-r lims(2)+r])
  legend('show', 'location', 'southoutside')
  xlabel("x [m]");
  ylabel("y [m]");
end

function [X, Y] = renderFilledCapsuleTank(d, L)
  N = 50;
  
  X = zeros(2*N+1,1);
  Y = zeros(2*N+1,1);
  
  r = d/2;
  
  i = 1;
  for theta = linspace(0, pi, N)
      X(i) = cos(theta)*r;
      Y(i) = L + sin(theta)*r;
      i = i+1;
  end
  
  for theta = linspace(pi, 2*pi, N)
      X(i) = cos(theta)*r;
      Y(i) = sin(theta)*r;
      i = i+1;
  end
  
  X(end) = X(1);
  Y(end) = Y(1);
end

function [X, Y] = renderCapsuleTank(d, L, t)
  N = 50;
  
  X = zeros(2*N+1,1);
  Y = zeros(2*N+1,1);
  
  r = d/2;
  
  i = 1;
  for theta = linspace(0, pi, N)
      X(i) = cos(theta)*r;
      Y(i) = L + sin(theta)*r;
      i = i+1;
  end
  
  for theta = linspace(pi, 2*pi, N)
      X(i) = cos(theta)*r;
      Y(i) = sin(theta)*r;
      i = i+1;
  end
  
  X(i) = X(1);
  Y(i) = Y(1);
  i = i+1;
  
  X(i) = X(1)-t;
  Y(i) = Y(1);
  i = i+1;
  
  for theta = linspace(2*pi, pi, N)
      X(i) = cos(theta)*(r-t);
      Y(i) = sin(theta)*(r-t);
      i = i+1;
  end
  
  for theta = linspace(pi, 0, N)
      X(i) = cos(theta)*(r-t);
      Y(i) = L + sin(theta)*(r-t);
      i = i+1;
  end
  
  X(i) = X(1);
  Y(i) = Y(1);
  i = i+1;
end