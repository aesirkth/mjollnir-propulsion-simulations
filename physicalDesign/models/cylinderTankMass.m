function [m, V_inner] = cylinderTankMass(R, L, t, density)
  V_inner = filledVolume(R-t, L);
  V = filledVolume(R, L) - V_inner;
  m = V * density;
end

function V = filledVolume(R, L)
  V = R*R*pi*L;
end