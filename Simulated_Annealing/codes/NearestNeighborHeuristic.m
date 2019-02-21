%function [visited_cities, L] = NearestNeighborHeuristic(X, Y)
% solves the TSP with Nearest Neighbor Heuristic
% X is the vector containing the x coordinate of the cities.
% Y is the vector containing the y coordinate of the cities.
% visited_cities gives the ordered list of visited cities
% L is the length of the path 
function [visited_cities, L] = NearestNeighborHeuristic(X, Y)

n = length(X);
D = constructDistanceMatrix(X,Y);


% initialize the values. 
visited_cities = [];
L = 0;

% choose the starting city at random
initial_city = 1 + floor(rand()*n);
current_city = initial_city;
visited_cities = current_city;

while length(visited_cities) < n
    
    % find the distance of the current city from all the others
    d = D(current_city, :);
    
    % set the value of distances to already visited cities large enough so
    % that they are not counted in the minimization
    d(visited_cities) = max(d)+1;
    
    % find the city with min distance
    [min_neighbor_edge_val, min_neighbor_edge_ind] = min(d);
    
    % update the current city
    current_city = min_neighbor_edge_ind(1);
    
    % add it to the list of visited cities
    visited_cities = [visited_cities; current_city];
    
    % update L
    L = L + min_neighbor_edge_val(1);
end

% add the starting city to the end of the list
L = L + D(visited_cities(end), initial_city);
visited_cities = [visited_cities; initial_city];

    
    

