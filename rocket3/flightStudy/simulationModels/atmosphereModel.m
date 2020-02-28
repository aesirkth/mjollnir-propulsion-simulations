
% Calculate atmospheric properties as function of height above surface in meters
function [density, pressure, speedOfSound] = atmosphereModel(h)
    h = max(1, h);
    [~,speedOfSound, pressure, density] = atmosisa(h);
    
    for i = 1:length(h)
        if h(i) > 20000
            density(i) = density(i) * max(0, 1-((h(i)-20000)/100000));
        end
    end
    
    for i = 1:length(h)
        if h(i) > 20000
            pressure(i) = pressure(i) * max(0, 1-((h(i)-20000)/100000));
        end
    end
end
