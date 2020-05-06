function [L, tMin, t, m, V] =  correctedCapsuleTank(externalRadius, desiredVolume, pressure, sigma, rho, rounding)
    tol = 1e-10;
    
    additionalLength = 0;
    for i = 1:1000
        Lstar = capsuleTankLength(desiredVolume, externalRadius);
        L = Lstar + additionalLength;
        tMin = capsuleTankThickness(externalRadius, pressure, sigma);
        t = ceil(tMin*1e3/ rounding) *rounding /1e3;

        [m, V] = capsuleTankMass(externalRadius, L, t, rho);

        delta = (desiredVolume - V);
        additionalLength = additionalLength + 1e2*delta;
        
        if abs(V - desiredVolume) < tol
            break
        end
    end

    L = capsuleTankLength(desiredVolume, externalRadius);
    L = L + additionalLength;
    tMin = capsuleTankThickness(externalRadius, pressure, sigma);
    [m, V] = capsuleTankMass(externalRadius, L, t, rho);
end