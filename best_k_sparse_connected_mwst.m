function [ E ] = best_k_sparse_connected_mwst( S,k )
%find k-sparse connected graph that contains mwst
%S: similarity matrix
%k: sparsity
[ E ] = best_spanning_tree( S );
n=size(S,1);
if (k>n-1)
   
    tree=E;
    
    possibleE= (~tree).*S.*(S>0);
    w=nonzeros(triu(possibleE,1));
    
    w=sort(w,'descend');
    
    threshold=w(k-n+1);
    
    %graph with the entries bigger thatn threshold
    E=(S>threshold);
    %now union of E and mwst
    E=spones(E+tree);
end
end

