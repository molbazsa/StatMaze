clc
clear
close

figure
axesm('globe');
gridm('GLineStyle','-','GColor',[.7 .8 .9],'Grid','on')

set(gca,'Box','off','Projection','perspective')
spin

base = zeros(180,360);
baseR = georefcells([-90 90],[0 360],size(base));
copperColor = [0.62 0.38 0.24];
hs = geoshow(base,baseR,'FaceColor',copperColor);
setm(gca, 'Galtitude',0.025);
axis vis3d
spin

clmo(hs)

load topo
topo = topo / (earthRadius('km')* 20);
hs = meshm(topo,topolegend,size(topo),topo);
demcmap(topo)

set(gcf,'color','black');
axis off
spin

camlight right
lighting Gouraud;
material([.7, .9, .8])
spin