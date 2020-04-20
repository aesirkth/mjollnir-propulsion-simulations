function nextPlot()
    global plotsWide plotsTall plotIndex;
    % drawnow
    subplot(plotsTall, plotsWide, plotIndex);
    plotIndex = plotIndex + 1;
end
