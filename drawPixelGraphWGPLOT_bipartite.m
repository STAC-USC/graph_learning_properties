%% Draw a grid graph with link weights having different colors 
% Inputs: A: Adjacency matrix
%         BS: block size
function drawPixelGraphWGPLOT_bipartite(A,BS,VLists)
addpath('wgPlot');
load ColorMatrix;
for i=1:BS
    for j=1:BS 
        pixel = i+(j-1)*BS;
       
         graph_points(pixel,2)= -i; % height
         graph_points(pixel,1)= j; % width
        
        
    end
end

%colors = colormap(Fire/255);
cmap=colormap(spring);
colors=1-cmap;
wgPlot_bipartite(A,graph_points,VLists,'edgeColorMap',colors,'edgeWidth',2.5);
set(gcf,'color','w');
% wgPlot(A,graph_points,'edgeColorMap',jet);
% set(gcf,'color','w');
