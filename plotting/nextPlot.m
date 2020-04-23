function nextPlot(name, w, h)
    global plotsWide plotsTall plotIndex storeFiguresToFile plotDirectory;

    if ~storeFiguresToFile
        subplot(plotsTall, plotsWide, mod(plotIndex - 1, plotsTall * plotsWide) + 1);
        plotIndex = plotIndex + 1;
    else
        if ~isempty(name)
            storeFigure(sprintf('%s/%s', plotDirectory, name), w, h);
            clf
        end
    end
    
end