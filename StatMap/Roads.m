clc
clear
close
%%roads = shaperead('hungary_roads.shp')
%%figure
%%mapshow('hungary_roads.shp','Linestyle',':');
type boston_roads.txt
roads = shaperead('boston_roads.shp')
histcounts([roads.CLASS],'BinLimits',[1,7],'BinMethod','Integer')
histcounts([roads.ADMIN_TYPE],'BinLimits',[0,3],'BinMethod','Integer')

roadspec = makesymbolspec('Line',... 
    {'Default', 'Color','green'},...
    {'ADMIN_TYPE',0,'Color','black'},...
    {'ADMIN_TYPE',3,'Color','blue'},...
    {'CLASS',6,'Visible','off'},...
    {'CLASS',5,'Visible','off'},...
    {'CLASS',[1,4],'LineWidth',2});

figure
mapshow('boston_roads.shp','SymbolSpec',roadspec);
xlabel('easting in meters')
ylabel('northing in meters')