% A smoothed Heaviside step function with continous first derivatives
function y = smoothHeaviside(t)
    eps = 1e-1;
    
    y = ones(length(t), 1);
    
    for i = 1:length(t)
        if(t(i) < -eps)
            y(i) = 0;
        elseif t(i) < eps
            y(i) = 0.5 - 0.5*cos((t(i) + eps) / (2*eps)*pi); 
        end
    end
end