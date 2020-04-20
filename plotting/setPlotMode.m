function setPlotMode(mode) 
  global storeFiguresToFile currentMode;
  

  if strcmp(mode, "save")
    close all
    clf

    set(gcf,'Resize','off')
    storeFiguresToFile = 1;
  end
  if strcmp(mode, "show")
    clf
    subplot(1,1,1);

    set(gcf,'Resize','on')
    storeFiguresToFile = 0;
  end
end