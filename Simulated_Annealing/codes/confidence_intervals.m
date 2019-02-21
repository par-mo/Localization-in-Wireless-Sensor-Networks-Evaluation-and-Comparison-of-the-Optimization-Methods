close all;
clear;
clc;
[~, X, Y] = textread('TSP_411.txt', '%d %f %f');
n = length(X);

for i = 1 : 50
[~, L] = NearestNeighborHeuristic(X, Y);
L_list(i) = L;
end;
ci_nearest_neighbor = bootci(50, @mean, L_list)
mean_nearest_neighbor = mean(L_list)
%%
for i = 1 : 50
[~, L] = BestInsertionHeuristic(X, Y);
L_list(i) = L;
end;
ci_best_insersion = bootci(50, @mean, L_list)
mean_best_insersion = mean(L_list)
%%
for i = 1 : 50
[~, L] = NearestInsertionHeuristic(X, Y);
L_list(i) = L;
end;
ci_nearest_insertion = bootci(50, @mean, L_list)
mean_nearest_insertion = mean(L_list)
%%
for i = 1 : 50
[~, L] = BestBestInsertionHeuristic(X, Y);
L_list(i) = L;
end;
ci_best_best_insertion = bootci(50, @mean, L_list)
mean_best_best_insertion = mean(L_list)