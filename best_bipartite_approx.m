function [ V1,V2,E ] = best_bipartite_approx( S)
%implement best bipartite approx using max-cut approximation algorithm from
% M.X. Goemans and D.P. Williamson, "Improved Approximation Algorithms for 
%Maximum Cut and Satisfiability Problems Using Semidefinite Programming"
%   
S=S.*(S>=0);
%S=abs(S);

%implement goemans williamson in cvx
n=size(S,1);
 cvx_begin sdp quiet
   
    variable Y(n,n) symmetric
    Y == semidefinite(n);
    minimize trace(S*Y);
    subject to
        diag(Y) == ones(n,1);
    cvx_end
%E=Y;
%V1=0;
%V2=0;

%chol decomposition
R=chol(Y);
%random vector in unit sphere
noise=randn(n,1);
noise=noise/norm(noise);
%compute test vector
signo=(R'*noise);
%define vertex set partition using the sign
V1=find(signo>0);
V2=find(signo<0);

%construct edge set of bipartite graph
E=zeros(n,n);
E(V1,V2)=S(V1,V2);
E(V2,V1)=S(V2,V1);

%take only entries with positive covariance matrix.
E=E.*(E>0);
E=spones(E);
end

