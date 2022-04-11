clc
clear
close

%%[table_overall_a] = Data;

table_location = readtable('Geolocation.xlsx');
Armedforces2020 = readtable('Armedforces2020.xlsx');


for i=1:1:height(Armedforces2020)
    index = find(strcmp(strtrim(Armedforces2020.Entity(i)),strtrim(table_location.name)));
    if ~isempty(index)
        latitude(i) = table_location.latitude(index);
        longitude(i) = table_location.longitude(index);
        
    else
        latitude(i) = 40;
        longitude(i) = 150;
        
    end
end

geotable = table(latitude',longitude',Armedforces2020.ArmedForcesPersonnel_Total);
geotable.Properties.VariableNames = {'latitude' 'longitude' 'Case'};
figure()
gb = geobubble(geotable,'latitude','longitude','SizeVariable','Case','Title','Geobubble Map For Armed Forces');

gb.SourceTable.Severity = discretize(Armedforces2020.ArmedForcesPersonnel_Total,[0 1000 10000 100000 1000000 100000000],'categorical', {'Low', 'Medium', 'High', 'Super High', 'Mega High'});

gb.ColorVariable = 'Severity';   