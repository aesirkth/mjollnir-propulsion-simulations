function nextPlot(name)
    global plotsWide plotsTall plotIndex storeFiguresToFile;
    if ~isempty(name)
        storeFigure(sprintf('./plots/%s', name));
        clf
    end
    
    if ~storeFiguresToFile
        subplot(plotsTall, plotsWide, plotIndex);
        plotIndex = plotIndex + 1;
    end
end
