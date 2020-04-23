% Events for the ODE solver
function [value,isterminal,direction] = combustionOdeSystemEvents(t, X)
    % X is of the form [oxidizerMass, fuelMass, portRadius, ccPressure]

    % First event is oxidizer mass is depleted
    value = [min(X(1), X(2))];

    % Terminate simulation when hitting the ground
    isterminal = [1];
    direction = [0];
end