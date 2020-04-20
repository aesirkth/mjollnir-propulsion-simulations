function nextPlot(name)
    global plotsWide plotsTall plotIndex storeFiguresToFile;

    if ~storeFiguresToFile
        subplot(plotsTall, plotsWide, plotIndex);
        plotIndex = plotIndex + 1;
    else
        if ~isempty(name)
            storeFigure(sprintf('./plots/%s', name));
            clf
        end
    end
    
end