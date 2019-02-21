% function D = constructDistanceMatrix(X,Y);
% constructs the distance matrix of the point set with x values in X and y
% values in Y without using a for loop
% D is the distances, not their squares
function D = constructDistanceMatrix(X, Y)

X = X(:);
Y = Y(:);

n = length(X);

XY_coor = [X, Y];
[k,kk] = find(triu(ones(n),1));
D = zeros(n);
D(k + n * (kk - 1)) = sqrt(sum((XY_coor(k,:) - XY_coor(kk,:)).^2, 2));
D(kk + n * (k - 1)) = D(k + n * (kk - 1));
end