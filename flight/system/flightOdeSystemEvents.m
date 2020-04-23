% Events for the ODE solver
function [value,isterminal,direction] = flightOdeSystemEvents(t, X)
  % First event is hitting the ground
  value = [X(2)];

  % Terminate simulation when hitting the ground
  isterminal = [1];
  direction = [-1];
end