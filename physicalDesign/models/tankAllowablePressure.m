function pressure = tankAllowablePressure(radius, thickness, Sigma)
  diameter = 2 * radius;
  pressure = thickness * Sigma * 2 / diameter; % https://en.wikipedia.org/wiki/Barlow%27s_formula
end