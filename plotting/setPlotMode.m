function setPlotMode(mode) 
  global storeFiguresToFile;

  close all
  clf
  if strcmp(mode, "save")
    set(gcf,'Resize','off')
    storeFiguresToFile = 1;
  end
  if strcmp(mode, "show")
    set(gcf,'Resize','on')
    storeFiguresToFile = 0;
  end
end