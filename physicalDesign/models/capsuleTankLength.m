function L = capsuleTankLength(V, R)
  L = (V - 4/3 * pi * R.^3) ./ (R.^2 * pi);
end