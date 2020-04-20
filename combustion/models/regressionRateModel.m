function regressionRate = regressionRateModel(portRadius,oxydizerMassFlow)
a = 15.5e-5;                            % Fuel constant
n = 0.5;                                % Fuel constant
A = pi * portRadius^2;
G_Ox = oxydizerMassFlow/A;
regressionRate = a*G_Ox^n;
end