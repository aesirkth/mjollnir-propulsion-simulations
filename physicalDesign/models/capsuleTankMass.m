function [m, V_inner] = capsuleTankMass(R, L, t, density)
    V_inner = filledVolume(R-t, L);
    V = filledVolume(R, L) - V_inner;
    m = V * density;
    % m_check = t .* (2*pi * R * density * (2*R + L));
    % m - m_check
end

function V = filledVolume(R, L)
    V_cylinder = R*R*pi*L;
    V_sphere = 4/3 * R*R*R * pi;

    V = V_cylinder + V_sphere;
end