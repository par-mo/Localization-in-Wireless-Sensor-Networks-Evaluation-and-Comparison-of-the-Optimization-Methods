%function [visited_cities, L] = BestInsertionHeuristic(X, Y)
% solves the TSP with Best Insertion Heuristic
% X is the vector containing the x coordinate of the cities.
% Y is the vector containing the y coordinate of the cities.
% visited_cities gives the ordered list of visited cities
% L is the length of the path 
function [visited_cities, L] = BestInsertionHeuristic(X, Y)


n = length(X);
D = constructDistanceMatrix(X,Y);


% initialize the values. 
visited_cities = [];
L = 0;

% save the length of visited edges in Ls
Ls = [];

% choose the 3 starting cities at random
% pick the first three random cities
randomOrder = randperm(n);
initial_cities = randomOrder(1:3);

% save the unvisited cities
unvisited_cities = 1 : n;
unvisited_cities = unvisited_cities(:);

% put the three initial cities in the list of visited cities
visited_cities = initial_cities;
visited_cities = visited_cities(:);

% remove the visited cities from the unvisited list
unvisited_cities(visited_cities) = [];

% put the traveled edges in Ls
Ls = [D(visited_cities(1), visited_cities(2)); D(visited_cities(2), visited_cities(3))];

% sum of Ls is the total travel distance
L = sum(Ls);


while length(visited_cities) < n
    % pick a random unvisited city
    randomOrder = randperm(length(unvisited_cities));
    selected_city = unvisited_cities(randomOrder(1));
    
    % find its distance from visited cities
    d = D(visited_cities, selected_city);
    
    % check if inserted in the list which position gives the min total
    % travel distance
    newLvec = L - Ls + (d(1:end-1) + d(2:end));
    [min_L, min_ind] = min(newLvec);
    min_ind = min_ind(1);
    % insert the new city in the desired position of the visited cities
    visited_cities = [visited_cities(1:min_ind); selected_city; visited_cities(min_ind+1:end)];
    
    % update Ls
    Ls = [Ls(1:min_ind-1); d(min_ind); d(min_ind+1); Ls(min_ind+1:end)];
    
    % update L
    L = min_L;
    
    % update unvisited cities
    unvisited_cities(unvisited_cities==selected_city) = [];
end
% add the starting city to the end of the list
L = L + D(visited_cities(end), initial_cities(1));
visited_cities = [visited_cities; initial_cities(1)];

    