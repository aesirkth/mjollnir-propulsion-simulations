function storeFigure(name, varargin)
    [dir] = fileparts(name);
    if ~exist(dir, 'dir')
      mkdir(dir)
    end
    
    x = 0;
    y = 0;
    
    
    if isempty(varargin)
        w = 600;
        h = 450;
    else 
        w = varargin{1};
        h = varargin{2};
    end
    
    axis tight
    set(gcf,'Resize','off')
    set(gcf,'Position',[x y w h])
    set(gca,'FontSize',14)
    
    drawnow
    %saveas(gcf,sprintf('%s.svg', name))
    saveas(gcf,sprintf('%s.png', name))
    
    fprintf("Saved to %s.png\n", name);
end