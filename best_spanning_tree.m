function [ tree ] = best_spanning_tree( S )
% compute maximum weight spanning tree
%   
S=S.*(S>0);
G=triu(S,1);

G=sparse(G+G');


[tree,~]=graphminspantree(-G,'method','Kruskal');
tree=-tree;
tree=tree+tree';
end

