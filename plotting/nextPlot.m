function nextPlot(name)
    global plotsWide plotsTall plotIndex storeFiguresToFile plotDirectory;

    if ~storeFiguresToFile
        subplot(plotsTall, plotsWide, plotIndex);
        plotIndex = plotIndex + 1;
    else
        if ~isempty(name)
            storeFigure(sprintf('%s/%s', plotDirectory, name));
            clf
        end
    end
    
end