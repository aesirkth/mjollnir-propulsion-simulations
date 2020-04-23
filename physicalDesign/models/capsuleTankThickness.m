function thickness = capsuleTankThickness(radius, pressure, Sigma)
  diameter = 2 * radius;
  thickness = pressure * diameter / (2 * Sigma); % https://en.wikipedia.org/wiki/Barlow%27s_formula
end