function setPlotMode(mode) 
  global storeFiguresToFile;

  if mode == "save"
    set(gcf,'Resize','off')
    storeFiguresToFile = 1;
  else if mode == "show"
    set(gcf,'Resize','on')
    storeFiguresToFile = 0;
  end
end