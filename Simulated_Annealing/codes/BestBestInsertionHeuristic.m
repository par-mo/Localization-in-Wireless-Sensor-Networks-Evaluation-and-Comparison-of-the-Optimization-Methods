%function [visited_cities, L] = BestBestInsertionHeuristic(X, Y)
% solves the TSP with Best Best Insertion Heuristic
% X is the vector containing the x coordinate of the cities.
% Y is the vector containing the y coordinate of the cities.
% visited_cities gives the ordered list of visited cities
% L is the length of the path 
function [visited_cities, L] = BestBestInsertionHeuristic(X, Y)


n = length(X);
D = constructDistanceMatrix(X,Y);


% initialize the values. 
visited_cities = [];
L = 0;

% save the length of visited edges in Ls
Ls = [];

% choose the starting city at random
randomOrder = randperm(n);
initial_city = randomOrder(1);

% find the second initial city by nearest neighbor
d = D(initial_city, :);
d(initial_city) = inf;
[~, second_initial_city] = min(d);

initial_cities = [initial_city; second_initial_city];
% save the unvisited cities
unvisited_cities = 1 : n;
unvisited_cities = unvisited_cities(:);

% put the three initial cities in the list of visited cities
visited_cities = initial_cities;
visited_cities = visited_cities(:);

% remove the visited cities from the unvisited list
unvisited_cities(visited_cities) = [];

% put the traveled edges in Ls
Ls = [D(visited_cities(1), visited_cities(2))];
Ls = Ls(:);

% sum of Ls is the total travel distance
L = sum(Ls);


while length(visited_cities) < n

    
    % find all the distances of the visited cities from unvisited ones
    d = D(visited_cities, unvisited_cities);
    
    % check if inserted in the list which position gives the min total
    % travel distance, check this for all unvisited cities at the same time
    newLvec = repmat(L - Ls, 1, length(unvisited_cities)) + (d(1:end-1,:) + d(2:end,:));
    [min_L, min_index] = min(newLvec(:));
    [min_ind, selected_city_ind] = ind2sub(size(newLvec), min_index);
    
    selected_city = unvisited_cities(selected_city_ind);
    
    % insert the new city in the desired position of the visited cities
    visited_cities = [visited_cities(1:min_ind); selected_city; visited_cities(min_ind+1:end)];
    
    % update Ls
    Ls = [Ls(1:min_ind-1); d(min_ind, selected_city_ind); d(min_ind+1, selected_city_ind); Ls(min_ind+1:end)];
    
    % update L
    L = min_L;
    
    % update unvisited cities
    unvisited_cities(unvisited_cities==selected_city) = [];
end
% add the starting city to the end of the list
L = L + D(visited_cities(end), initial_cities(1));
visited_cities = [visited_cities; initial_cities(1)];

