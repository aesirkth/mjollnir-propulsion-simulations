% Drag model
function drag = dragModel(velocity, ambientAirDensity, radius, Cd)
    frontalArea = radius*radius*pi;
    
    drag = Cd .* 0.5 .* ambientAirDensity .* velocity.^2 .* frontalArea;
end