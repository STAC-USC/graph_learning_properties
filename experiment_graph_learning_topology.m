%experiment graph learning trees from texture images in brodats rotated
%textures

clear;

addpath(genpath('..\Graph_Learning-master'));
brodatz_folder='brodatz_rotated\';

topology_type = 0;      %sparse
%topology_type = 1;     %tree
%topology_type = 2;     %bipartite
bsize=8; %block size of images
my_eps_outer = 1e-4; my_eps_inner = 1e-6; max_cycles = 100; % convergence parameters for graph learning function estimate_ggl
alpha=0;
%set parameters for each case
if( topology_type == 0)
    %sparsity level, k_edge>=n-1
    k_edge=2*bsize*(bsize-1); %2*bsize*(bsize-1) = number of edges in 4-connected grid graph
end
%load image
texture_index =6;
textures=sprintf('%sstraw*.tiff',brodatz_folder);
files=dir(textures);
name=sprintf('%s%s',brodatz_folder,files(texture_index).name);

texture_angle=files(texture_index).name(7:9);
texture_name=sprintf('plots/straw%s.png',texture_angle);

im=(imread(name));

im=double(im);

%partition image into bsize x bsize blocks, vectorize and stack them
[a,b]=size(im);

n1=a/bsize;
n2=b/bsize;
data=[];
for i=1:n1
    for j=1:n1
        start_i=bsize*(i-1)+1;
        start_j=bsize*(j-1)+1;
        
        X=im(start_i:start_i+bsize-1,start_j:start_j+bsize-1);
        x=X(:)';
        data=[data;x];
        
    end
end
%compute covariance
S=cov(data);
S_pos=S.*(S>0);
tic;
rr=inv(sqrt(diag(diag(S))));

switch topology_type
    case 0
        A=best_k_sparse_connected_mwst( rr*S_pos*rr,k_edge );
        VLists{1}= 1:1:bsize^2; VLists{2}=1:1:bsize^2;
        
    case 1
        [ A_tree] = best_spanning_tree(rr*S_pos*rr );
        A=spones(A_tree);
        VLists{1}= 1:1:bsize^2; VLists{2}=1:1:bsize^2;
    case 2
        [ V1,V2,A ] = best_bipartite_approx( rr*S_pos*rr );
        VLists{1}= V1; VLists{2}=V2;
        
        
end

[Laplacian,~,convergence] = estimate_ggl(S,A,alpha,my_eps_outer,my_eps_inner,max_cycles,2);
Adj = laplacianToAdjacency(Laplacian,0);
figure;
drawPixelGraphWGPLOT_bipartite(Adj,bsize,VLists);




