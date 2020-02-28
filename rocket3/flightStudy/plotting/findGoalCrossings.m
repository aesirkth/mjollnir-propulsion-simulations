% clf
% clc
% 
% x = linspace(0, pi, 1000);
% 
% goal = 0.45;
% 
% subplot(2,3,1);
% y = cos(x);
% plot(x,y)
% hold on
% plot([min(x) max(x)], [goal goal], '--');
% [upwardCrossings, downwardCrossings] = findGoalCrossings(x, y, goal);
% plot(upwardCrossings, goal * ones(length(upwardCrossings), 1), 'bx', 'LineWidth', 2, 'MarkerSize', 10)
% plot(downwardCrossings, goal * ones(length(downwardCrossings), 1), 'ro', 'LineWidth', 2, 'MarkerSize', 10)
% 
% subplot(2,3,2);
% y = sin(x) - 0.5;
% plot(x,y)
% hold on
% plot([min(x) max(x)], [goal goal], '--');
% [upwardCrossings, downwardCrossings] = findGoalCrossings(x, y, goal);
% plot(upwardCrossings, goal * ones(length(upwardCrossings), 1), 'bx', 'LineWidth', 2, 'MarkerSize', 10)
% plot(downwardCrossings, goal * ones(length(downwardCrossings), 1), 'ro', 'LineWidth', 2, 'MarkerSize', 10)
% 
% subplot(2,3,3);
% y = -cos(x);
% plot(x,y)
% hold on
% plot([min(x) max(x)], [goal goal], '--');
% [upwardCrossings, downwardCrossings] = findGoalCrossings(x, y, goal);
% plot(upwardCrossings, goal * ones(length(upwardCrossings), 1), 'bx', 'LineWidth', 2, 'MarkerSize', 10)
% plot(downwardCrossings, goal * ones(length(downwardCrossings), 1), 'ro', 'LineWidth', 2, 'MarkerSize', 10)
% 
% subplot(2,3,4);
% y = sin(x) - 1.5;
% plot(x,y)
% hold on
% plot([min(x) max(x)], [goal goal], '--');
% [upwardCrossings, downwardCrossings] = findGoalCrossings(x, y, goal);
% plot(upwardCrossings, goal * ones(length(upwardCrossings), 1), 'bx', 'LineWidth', 2, 'MarkerSize', 10)
% plot(downwardCrossings, goal * ones(length(downwardCrossings), 1), 'ro', 'LineWidth', 2, 'MarkerSize', 10)
% 
% subplot(2,3,5);
% y = cos(4*x);
% plot(x,y)
% hold on
% plot([min(x) max(x)], [goal goal], '--');
% [upwardCrossings, downwardCrossings] = findGoalCrossings(x, y, goal);
% plot(upwardCrossings, goal * ones(length(upwardCrossings), 1), 'bx', 'LineWidth', 2, 'MarkerSize', 10)
% plot(downwardCrossings, goal * ones(length(downwardCrossings), 1), 'ro', 'LineWidth', 2, 'MarkerSize', 10)
% 
% subplot(2,3,6);
% y = sin(4*x);
% plot(x,y)
% hold on
% plot([min(x) max(x)], [goal goal], '--');
% [upwardCrossings, downwardCrossings] = findGoalCrossings(x, y, goal);
% plot(upwardCrossings, goal * ones(length(upwardCrossings), 1), 'bx', 'LineWidth', 2, 'MarkerSize', 10)
% plot(downwardCrossings, goal * ones(length(downwardCrossings), 1), 'ro', 'LineWidth', 2, 'MarkerSize', 10)

function [hasAnyCrossings, upwardCrossings, downwardCrossings] = findGoalCrossings(x, y, goal)
    y = y - goal;
    
    ab = y(1:end-1).*y(2:end);
    crossingIndices = find(ab < 0);
    
    
    crossings = zeros(1, length(crossingIndices));
    for i = 1:length(crossings)
        xv = x(crossingIndices(i) + (0:1));
        yv = y(crossingIndices(i) + (0:1));
        
        ratio = (yv(1)) / (yv(2) - yv(1));
        crossings(i) = xv(1) - (xv(2) - xv(1)) * ratio;
    end
    
    upwardCrossingIndices = (y(crossingIndices) < 0); 
    downwardCrossingsIndices = (y(crossingIndices) > 0); 
    
    hasAnyCrossings = length(crossings) > 0;
    upwardCrossings = crossings(upwardCrossingIndices);
    downwardCrossings = crossings(downwardCrossingsIndices);
end