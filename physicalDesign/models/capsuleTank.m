function [m, L, t, m_check, t_check] = capsuleTank(V, R, P, Sigma, rho, safetyMargin)
    L = (V - 4/3 * pi * R.^3) ./ (R.^2 * pi);
    m = 2 * pi * R.^2 .* (R + L) * P * (rho / Sigma) * safetyMargin;
    t = m ./ (2*pi * R * rho * (2*R + L));
    t_check = safetyMargin*R*P/Sigma;                          % Barlow's formula: https://en.wikipedia.org/wiki/Barlow%27s_formula
    m_check = t_check .* (2*pi * R * rho * (2*R + L));
end