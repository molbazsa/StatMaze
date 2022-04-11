clc
clear
close

figure
mapshow boston.tif
%%axis image manual off

S = shaperead('boston_placenames.shp');

surveyFeetPerMeter = unitsratio('sf', 'meter');

for k = 1:numel(S)
    S(k).X = surveyFeetPerMeter * S(k).X;
    S(k).Y = surveyFeetPerMeter * S(k).Y;
end

text([S.X], [S.Y], {S.NAME}, 'Color', [0 0 0], ...
    'BackgroundColor',[0.9 0.9 0.9], 'Clipping','on');