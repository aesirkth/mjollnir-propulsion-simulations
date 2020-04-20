function scaleLims(factor)
    lims = ylim;
    range = lims(2) - lims(1);
    ylim([ lims(1)-range*factor lims(2)+range*factor  ]);
end
