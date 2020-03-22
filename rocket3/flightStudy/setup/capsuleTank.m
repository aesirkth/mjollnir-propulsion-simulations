function [m, L, t, R] = capsuleTank(V, R, P, rhoOverSigma, Sigma, rho, s)
    L = (V - 4/3 * pi * R.^3) ./ (R.^2 * pi);
    m = 2 * pi * R.^2 .* (R + L) * P * rhoOverSigma * s;
    t = m ./ (2*pi * R * rho * (2*R + L));
    t_check = s*R*P/Sigma;                          % Barlow's formula: https://en.wikipedia.org/wiki/Barlow%27s_formula
    m_check = t_check .* (2*pi * R * rho * (2*R + L));
end