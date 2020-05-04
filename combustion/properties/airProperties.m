function air = airProperties(p, T)
% Get fluid properties: air

air.cp = py.CoolProp.CoolProp.PropsSI('C','P',p,'T',T,'air');
air.rho = py.CoolProp.CoolProp.PropsSI('D','P',p,'T',T,'air');
air.mu = py.CoolProp.CoolProp.PropsSI('V','P',p,'T',T,'air');
air.k = py.CoolProp.CoolProp.PropsSI('L','P',p,'T',T,'air');

end