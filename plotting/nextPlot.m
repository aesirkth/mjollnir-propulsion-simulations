function nextPlot(name, varargin)
    global plotsWide plotsTall plotIndex storeFiguresToFile plotDirectory;

    if ~storeFiguresToFile
        subplot(plotsTall, plotsWide, mod(plotIndex - 1, plotsTall * plotsWide) + 1);
        plotIndex = plotIndex + 1;
    else
        if ~isempty(name)
            if isempty(varargin)
                w = 600;
                h = 450;
            else 
                w = varargin{1};
                h = varargin{2};
            end
            storeFigure(sprintf('%s/%s', plotDirectory, name), w, h);
            clf
        end
    end
    
end