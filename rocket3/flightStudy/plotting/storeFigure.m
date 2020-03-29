function storeFigure(name)
    [dir] = fileparts(name);
    if ~exist(dir, 'dir')
      mkdir(dir)
    end
    
    x = 0;
    y = 0;
    w = 500;
    h = 300;
    
    axis tight
    set(gcf,'Resize','off')
    set(gcf,'Position',[x y w h])
    set(gca,'FontSize',14)
    
    drawnow
    %saveas(gcf,sprintf('%s.svg', name))
    saveas(gcf,sprintf('%s.png', name))
    
    fprintf("Saved to %s.png\n", name);
end