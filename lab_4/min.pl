min(X,[X]).                 

min(X,[L,L1|L2]) :- L =< L1, min(X,[L|L2]).               

min(X,[L,L1|L2]) :- L > L1, min(X,[L1|L2]).