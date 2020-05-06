function ox = oxidizerPropertiesPressure(method,p,entropy, props, opts)
%{
Args:
    p (double):     pressure for the given state [K]
    props (cell):   properties which are to be determined for the given state define by T, contains strings
Returns:
    ox(struct):     contains fields in which the desired fluid properties of the given state are stores
%}

% Get fluid props: N2O
% liquid phase (% Q = 0: saturated liquid)
% gaseous phase (Q = 1: saturated vapor)

% Get data for interpolation

if strcmp(method, 'interp')
    for zz = 1:length(props)
        if strcmp(props{zz}, 's_l')
            ox.s_l = interp1(opts.oxidizerData.p, opts.oxidizerData.s_l, p);
%         elseif strcmp(props{zz}, 'h_sconst')
%             ox.h_sconst = interp1(opts.oxidizerData.p, opts.oxidizerData.h_sconst, p);
%         elseif strcmp(props{zz}, 'rho_sconst')
%             ox.rho_sconst = interp1(opts.oxidizerData.p, opts.oxidizerData.rho_sconst, p);
        end
    end
    
elseif strcmp(method, 'coolprop')
    for zz = 1:length(props)
%         if strcmp(props{zz}, 's_l')
%             ox.s_l = py.CoolProp.CoolProp.PropsSI('S','P',p,'Q',0,'N2O');    
        if strcmp(props{zz}, 'h_sconst')
            ox.h_sconst = py.CoolProp.CoolProp.PropsSI('H','P',p,'S',entropy,'N2O');
        elseif strcmp(props{zz}, 'rho_sconst')
            ox.rho_sconst = py.CoolProp.CoolProp.PropsSI('D','P',p,'S',entropy,'N2O');
        end
    end
    
end
end


