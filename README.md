# graph_learning_properties

This MATLAB package includes implementations of the graph learning algorithms presented in [1].
It requires the GLL package, which implements the algorithms from [2].
The wgplot toolbox is included to generate figures.
Some of the rotated Brodatz textures are also included (http://sipi.usc.edu/database/database.php?volume=rotate).

[1] Pavez, Eduardo, Hilmi E. Egilmez, and Antonio Ortega. "Learning graphs with monotone topology properties and multiple connected components." IEEE Transactions on Signal Processing 66.9 (2018): 2399-2413.

Arxiv version: https://arxiv.org/abs/1705.10934


[2] H. E. Egilmez, E. Pavez, and A. Ortega, "Graph learning from data under Laplacian and structural constraints," IEEE Journal of Selected Topics in Signal Processing, 2017.
   
 Arxiv version: https://arxiv.org/abs/1611.05181


To install the package:
(1) Download the source files.
(2) Download GLL package https://github.com/STAC-USC/Graph_Learning
(3) Download/install CVX (requried for learning bipartite graphs)

The demo script 'experiment_graph_learning_topology.m' shows the usage of functions used to estimate generalized graph Laplacian matrices with topology properties (sparse connected, tree, bipartite).  




