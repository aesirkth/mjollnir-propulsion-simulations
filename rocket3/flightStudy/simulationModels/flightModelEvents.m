% Events for the ODE solver
function [value,isterminal,direction] = flightModelEvents(t, X)
    % X is of the form [positionX, positionY, velocityX, velocityY, propellantMass]

    % First event is hitting the ground
    % Second event is when oxidizer mass is depleted
    value = [X(2) + 1,X(5)];

    % Terminate simulation when hitting the ground
    isterminal = [1 0];
    direction = [0];
end