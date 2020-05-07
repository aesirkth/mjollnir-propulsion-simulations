run("./combustion/properties/cstarInterpolationTable")

Height = 21;
Width = length(cstarTable) / Height;

pressures = cstarTable(:,1);
ofRatios = cstarTable(:,2);
cStars = cstarTable(:,3);

pressures = reshape(pressures, Height, Width)';
ofRatios = reshape(ofRatios, Height, Width)';
cStars = reshape(cStars, Height, Width)';

cStar = interp2(pressures, ofRatios, cStars, ccPressure, of, 'linear', 1500)