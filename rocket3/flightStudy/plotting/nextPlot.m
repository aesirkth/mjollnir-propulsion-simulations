function nextPlot(name)
    global plotsWide plotsTall plotIndex storeFiguresToFile;
    
    if ~storeFiguresToFile
        if plotIndex <= plotsTall*plotsWide
            subplot(plotsTall, plotsWide, plotIndex);
            plotIndex = plotIndex + 1;
        end
    else
        if ~isempty(name)
            storeFigure(sprintf('./plots/%s', name));
        end
        clf
    end
end
