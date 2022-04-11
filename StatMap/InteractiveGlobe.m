clc
clear
close

figure
axesm bries
text(.8, -1.8, 'Briesemeister projection')
framem('FLineWidth',1)

load topo
geoshow(topo,topolegend, 'DisplayType', 'texturemap')

demcmap(topo)
brighten(.5)

load coastlines

[rlat, rlon] = reducem(coastlat,coastlon, 0.25);

geoshow(rlat, rlon, 'Color', [.6 .5 .2], 'LineWidth', 1.5)

cities = shaperead('worldcities', 'UseGeoCoords',true);

lats = extractfield(cities, 'Lat');
lons = extractfield(cities, 'Lon');
geoshow(lats, lons,...
    'DisplayType', 'point',...
    'Marker','o',...
    'MarkerEdgeColor','r',...
    'MarkerFaceColor','r',...
    'MarkerSize',3)
text(-2.8,-1.8,'Major World Cities')
runCitySelectionLoop = true;
if(runCitySelectionLoop)
    h1 = text(-2.8, 1.9, 'Click on a dot for  its city name. Press ENTER to stop');
    h2 = text(-2.8, 1.7, '');
    h3 = text(-2.8,1.5, 'City Coordinates.');
    while true
        [selected_lat,selected_lon] = inputm(1);
        if isempty(selected_lat)
            break 
        end
        
        d = distance(lats, lons, selected_lat, selected_lon);
        k = find(d == min(d(:)),1);
        city = cities(k);
        geoshow(city.Lat, city.Lon, ...
            'DisplayType', 'point', ...
            'Marker', 'o', ...
            'MarkerEdgeColor', 'k', ...
            'MarkerFaceColor', 'y', ...
            'MarkerSize', 3)
        h2.String = city.Name;
        h3.String = num2str([city.Lat, city.Lon],'%10.2f');
    end
    disp('End of Input.')
end

        