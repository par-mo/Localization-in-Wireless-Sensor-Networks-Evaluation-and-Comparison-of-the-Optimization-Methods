close all;
clear;
[~, X, Y] = textread('TSP_411.txt', '%d %f %f');
n = length(X);

%% Nearest Neighbor Heuristic
% [visited_cities, L] = NearestNeighborHeuristic(X, Y);

%% Best Insetion Heuristic
% [visited_cities, L] = BestInsertionHeuristic(X, Y);


%% Nearest Insetion Heuristic
% [visited_cities, L] = NearestInsertionHeuristic(X, Y)


%% Best Best Insertion Heuristic
% [visited_cities, L] = BestBestInsertionHeuristic(X, Y)
% figure(1);
% hold on;
% for i = 1 : n
%     plot(X(i), Y(i), 'o', 'markersize', 4, 'linewidth',2);
%     line([X(visited_cities(i)); X(visited_cities(i+1))], [Y(visited_cities(i)); Y(visited_cities(i+1))], 'linewidth', 2);
% end
% text(X(visited_cities(1))+.4, Y(visited_cities(1))+.4, num2str(1),'fontsize', 14);
% axis equal
% set(gca, 'fontsize', 14);
% box off; 
% axis off;
% print -depsc bestbestinsertion.eps


%% Local Search

% local serach : swap
load nearest_neighbor_vars;
% [new_visited_cities, new_L, Lvec] = localSearchTSP(X, Y, visited_cities, L, 'swap');

% figure(1);
% hold on;
% for i = 1 : n
%     plot(X(i), Y(i), 'o', 'markersize', 4, 'linewidth',2);
%     line([X(visited_cities(i)); X(visited_cities(i+1))], [Y(visited_cities(i)); Y(visited_cities(i+1))], 'linewidth', 2);
% end
% axis equal
% set(gca, 'fontsize', 14);
% box off; 
% axis off;
% print -depsc constructionnearestNeighbor.eps
% 
% figure(2);
% hold on;
% for i = 1 : n
%     plot(X(i), Y(i), 'o', 'markersize', 4, 'linewidth',2);
%     line([X(new_visited_cities(i)); X(new_visited_cities(i+1))], [Y(new_visited_cities(i)); Y(new_visited_cities(i+1))], 'linewidth', 2);
% end
% axis equal
% set(gca, 'fontsize', 14);
% box off; 
% axis off;
% print -depsc swap.eps
% 
% figure(3);
% hold on;
% plot(Lvec, 'linewidth', 2);
% set(gca, 'fontsize', 14);
% print -depsc swap_convergence.eps


% local search : translation
% [new_visited_cities, new_L, Lvec] = localSearchTSP(X, Y, visited_cities, L, 'translation');

% figure(2);
% hold on;
% for i = 1 : n
%     plot(X(i), Y(i), 'o', 'markersize', 4, 'linewidth',2);
%     line([X(new_visited_cities(i)); X(new_visited_cities(i+1))], [Y(new_visited_cities(i)); Y(new_visited_cities(i+1))], 'linewidth', 2);
% end
% axis equal
% set(gca, 'fontsize', 14);
% box off; 
% axis off;
% print -depsc translation.eps
% 
% figure(3);
% hold on;
% plot(Lvec, 'linewidth', 2);
% set(gca, 'fontsize', 14);
% print -depsc translation_convergence.eps


% local search : inversion
% [new_visited_cities, new_L, Lvec] = localSearchTSP(X, Y, visited_cities, L, 'inversion');
% 
% figure(2);
% hold on;
% for i = 1 : n
%     plot(X(i), Y(i), 'o', 'markersize', 4, 'linewidth',2);
%     line([X(new_visited_cities(i)); X(new_visited_cities(i+1))], [Y(new_visited_cities(i)); Y(new_visited_cities(i+1))], 'linewidth', 2);
% end
% axis equal
% set(gca, 'fontsize', 14);
% box off; 
% axis off;
% print -depsc inversion.eps
% 
% figure(3);
% hold on;
% plot(Lvec, 'linewidth', 2);
% set(gca, 'fontsize', 14);
% print -depsc inversion_convergence.eps


% local search : all methods together
% [new_visited_cities, new_L, Lvec] = localSearchTSP(X, Y, visited_cities, L, 'all');
% 
% figure(2);
% hold on;
% for i = 1 : n
%     plot(X(i), Y(i), 'o', 'markersize', 4, 'linewidth',2);
%     line([X(new_visited_cities(i)); X(new_visited_cities(i+1))], [Y(new_visited_cities(i)); Y(new_visited_cities(i+1))], 'linewidth', 2);
% end
% axis equal
% set(gca, 'fontsize', 14);
% box off; 
% axis off;
% print -depsc all.eps
% 
% figure(3);
% hold on;
% plot(Lvec, 'linewidth', 2);
% set(gca, 'fontsize', 14);
% print -depsc all_convergence.eps

%% Simulated Annealing

[new_visited_cities, new_L, Lvec] = simulatedAnnealingTSP(X, Y, visited_cities, L, 'metropolis');


% figure(2);
% hold on;
% for i = 1 : n
%     plot(X(i), Y(i), 'o', 'markersize', 4, 'linewidth',2);
%     line([X(new_visited_cities(i)); X(new_visited_cities(i+1))], [Y(new_visited_cities(i)); Y(new_visited_cities(i+1))], 'linewidth', 2);
% end
% axis equal
% set(gca, 'fontsize', 14);
% box off; 
% axis off;
% print -depsc SA_metroT0100b07it10.eps

% figure(3);
% hold on;
% plot(Lvec, 'linewidth', 2);
% set(gca, 'fontsize', 14);
% print -depsc SA_metroT0100b07it10_convergence.eps

% [new_visited_cities, new_L, Lvec] = simulatedAnnealingTSP(X, Y, visited_cities, L, 'heat bath');

% figure(2);
% hold on;
% for i = 1 : n
%     plot(X(i), Y(i), 'o', 'markersize', 4, 'linewidth',2);
%     line([X(new_visited_cities(i)); X(new_visited_cities(i+1))], [Y(new_visited_cities(i)); Y(new_visited_cities(i+1))], 'linewidth', 2);
% end
% axis equal
% set(gca, 'fontsize', 14);
% box off; 
% axis off;
% print -depsc SA_metroT0100b07it10.eps

% figure(3);
% hold on;
% plot(Lvec, 'linewidth', 2);
% set(gca, 'fontsize', 14);
% print -depsc SA_heatT0100b07it10_convergence.eps
% %% Genetic Algorithm
% 
for i = 1 : 10
    
    [visited_cities, L] = NearestNeighborHeuristic(X, Y);
    visited_cities_mat(:,i) = visited_cities;
    L_mat(i) = L;
    
end
L_mat = L_mat(:);
[new_visited_cities, new_L, Lvec] = geneticTSP(X, Y, visited_cities_mat, L_mat, 'swap');

% 
% figure(2);
% hold on;
% for i = 1 : n
%     plot(X(i), Y(i), 'o');
%     text(X(i)+.4, Y(i)+.4, num2str(i));
%     text(X(new_visited_cities(i))+.2, Y(new_visited_cities(i))+.2, num2str(i),'color','red');
%     line([X(new_visited_cities(i)); X(new_visited_cities(i+1))], [Y(new_visited_cities(i)); Y(new_visited_cities(i+1))], 'linewidth', 2);
% end
