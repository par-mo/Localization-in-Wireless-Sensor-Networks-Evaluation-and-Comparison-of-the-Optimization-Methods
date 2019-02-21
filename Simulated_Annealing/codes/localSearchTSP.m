function [new_visited_cities, new_L, Lvec] = localSearchTSP(X, Y, visited_cities, L, search_option)
n = length(X);

max_moves = 50* n^2;

switch search_option
    case 'swap',
        [new_visited_cities, new_L, Lvec] = swapMove(X, Y, visited_cities, L, max_moves);
    case 'translation',
        [new_visited_cities, new_L, Lvec] = translationMove(X, Y, visited_cities, L, max_moves);
    case 'inversion',
        [new_visited_cities, new_L, Lvec] = inversionMove(X, Y, visited_cities, L, max_moves);
    case 'all',
        [new_visited_cities, new_L, Lvec] = allMove(X, Y, visited_cities, L, max_moves);
    otherwise,
        error('option not valid');
end

end
function [new_visited_cities, new_L, Lvec] = swapMove(X, Y, visited_cities, L, max_moves)

n = length(X);
D = constructDistanceMatrix(X,Y);

Lvec = zeros(max_moves, 1);

for k = 1 : max_moves
    
    i = 1+floor(rand()*n);
    j = 1+floor(rand()*n);
    while j == i
        j = 1+floor(rand()*n);
    end
    i_p = i+1;
    if i == n
        i_p = 1;
    end
    
    i_m = i-1;
    if i == 1
        i_m = n;
    end
    
    j_p = j+1;
    if j == n
        j_p = 1;
    end
    
    j_m = j-1;
    if j == 1
        j_m = n;
    end
    
    if i_p == j
        new_L_tmp = L + D(visited_cities(i_m), visited_cities(j))+ D(visited_cities(i), visited_cities(j_p)) - D(visited_cities(i_m), visited_cities(i)) - D(visited_cities(j), visited_cities(j_p));
    elseif j_p == i
        new_L_tmp = L + D(visited_cities(j_m), visited_cities(i))+ D(visited_cities(j), visited_cities(i_p)) - D(visited_cities(j_m), visited_cities(j)) - D(visited_cities(i), visited_cities(i_p));
    else
        new_L_tmp = L + D(visited_cities(i_m), visited_cities(j)) + D(visited_cities(j), visited_cities(i_p)) + D(visited_cities(j_m), visited_cities(i)) + D(visited_cities(i), visited_cities(j_p)) - D(visited_cities(i_m), visited_cities(i)) - D(visited_cities(i), visited_cities(i_p)) - D(visited_cities(j_m), visited_cities(j)) - D(visited_cities(j), visited_cities(j_p));
    end
    if new_L_tmp <= L
        L = new_L_tmp;
        ind = 1 : n+1;
        ind(i) = j;
        ind(j) = i;
        visited_cities = visited_cities(ind);
    end
    Lvec(k) = L;
    
end
new_visited_cities = visited_cities;
new_visited_cities = [new_visited_cities; new_visited_cities(1)];
new_L = L;

end

function [new_visited_cities, new_L, Lvec] = translationMove(X, Y, visited_cities, L, max_moves)

n = length(X);
D = constructDistanceMatrix(X,Y);

Lvec = zeros(max_moves, 1);

for k = 1 : max_moves
    
    i = 1+floor(rand()*n);
    
    i_p = i+1;
    if i == n
        i_p = 1;
    end
    
    i_m = i-1;
    if i == 1
        i_m = n;
    end
    
    j = 1+floor(rand()*n);
    
    while (j == i || j==i_p)
        j = 1+floor(rand()*n);
    end
    
    j_p = j+1;
    if j == n
        j_p = 1;
    end
    
    j_m = j-1;
    if j == 1
        j_m = n;
    end
    
    if i_p == j_m
        new_L_tmp = L + D(visited_cities(i), visited_cities(j))+ D(visited_cities(i_p), visited_cities(j_p)) - D(visited_cities(i), visited_cities(i_p)) - D(visited_cities(j), visited_cities(j_p));
    elseif j_p == i
        new_L_tmp = L + D(visited_cities(j_m), visited_cities(i))+ D(visited_cities(j), visited_cities(i_p)) - D(visited_cities(j_m), visited_cities(j)) - D(visited_cities(i), visited_cities(i_p));
    else
        new_L_tmp = L + D(visited_cities(i), visited_cities(j)) + D(visited_cities(j), visited_cities(i_p)) + D(visited_cities(j_m), visited_cities(j_p)) - D(visited_cities(i), visited_cities(i_p)) - D(visited_cities(j_m), visited_cities(j)) - D(visited_cities(j), visited_cities(j_p));
    end
    if new_L_tmp <= L
        L = new_L_tmp;
        ind = 1 : n+1;
        if i < j
            ind = [ind(1:i), j, ind(i+1:j-1), ind(j+1:end)];
        else
            ind = [ind(1:j-1), ind(j+1:i), j, ind(i+1:end)];
        end
        visited_cities = visited_cities(ind);
    end
    Lvec(k) = L;
    
end
new_visited_cities = visited_cities;
new_visited_cities = [new_visited_cities; new_visited_cities(1)];
new_L = L;
end


function [new_visited_cities, new_L, Lvec] = inversionMove(X, Y, visited_cities, L, max_moves)

n = length(X);
D = constructDistanceMatrix(X,Y);

Lvec = zeros(max_moves, 1);

for k = 1 : max_moves
    
    i = 1+floor(rand()*n);
    
    i_p = i+1;
    if i == n
        i_p = 1;
    end
    
    i_m = i-1;
    if i == 1
        i_m = n;
    end
    
    j = 1+floor(rand()*n);
    
    while (j == i || j==i_p || j==i_m)
        j = 1+floor(rand()*n);
    end
    if i < j
        
        j_p = j+1;
        if j == n
            j_p = 1;
        end
        
        new_L_tmp = L + D(visited_cities(i), visited_cities(j))+ D(visited_cities(i_p), visited_cities(j_p)) - D(visited_cities(i), visited_cities(i_p)) - D(visited_cities(j), visited_cities(j_p));
        
        if new_L_tmp <= L
            L = new_L_tmp;
            ind = 1 : n+1;
            ind = [ind(1:i), ind(j:-1:i+1), ind(j+1:end)];
            visited_cities = visited_cities(ind);
        end
    end
    Lvec(k) = L;
    
end
new_visited_cities = visited_cities;
new_visited_cities = [new_visited_cities; new_visited_cities(1)];
new_L = L;
end


function [new_visited_cities, new_L, Lvec] = allMove(X, Y, visited_cities, L, max_moves)

n = length(X);
D = constructDistanceMatrix(X,Y);

Lvec = zeros(max_moves, 1);

for k = 1 : max_moves
    
    u = rand();
    if u < 1/3 % swap
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
         i = 1+floor(rand()*n);
    j = 1+floor(rand()*n);
    while j == i
        j = 1+floor(rand()*n);
    end
    i_p = i+1;
    if i == n
        i_p = 1;
    end
    
    i_m = i-1;
    if i == 1
        i_m = n;
    end
    
    j_p = j+1;
    if j == n
        j_p = 1;
    end
    
    j_m = j-1;
    if j == 1
        j_m = n;
    end
    
    if i_p == j
        new_L_tmp = L + D(visited_cities(i_m), visited_cities(j))+ D(visited_cities(i), visited_cities(j_p)) - D(visited_cities(i_m), visited_cities(i)) - D(visited_cities(j), visited_cities(j_p));
    elseif j_p == i
        new_L_tmp = L + D(visited_cities(j_m), visited_cities(i))+ D(visited_cities(j), visited_cities(i_p)) - D(visited_cities(j_m), visited_cities(j)) - D(visited_cities(i), visited_cities(i_p));
    else
        new_L_tmp = L + D(visited_cities(i_m), visited_cities(j)) + D(visited_cities(j), visited_cities(i_p)) + D(visited_cities(j_m), visited_cities(i)) + D(visited_cities(i), visited_cities(j_p)) - D(visited_cities(i_m), visited_cities(i)) - D(visited_cities(i), visited_cities(i_p)) - D(visited_cities(j_m), visited_cities(j)) - D(visited_cities(j), visited_cities(j_p));
    end
    if new_L_tmp <= L
        L = new_L_tmp;
        ind = 1 : n+1;
        ind(i) = j;
        ind(j) = i;
        visited_cities = visited_cities(ind);
    end
    Lvec(k) = L;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    elseif u < 2/3 % translation
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        i = 1+floor(rand()*n);
    
    i_p = i+1;
    if i == n
        i_p = 1;
    end
    
    i_m = i-1;
    if i == 1
        i_m = n;
    end
    
    j = 1+floor(rand()*n);
    
    while (j == i || j==i_p)
        j = 1+floor(rand()*n);
    end
    
    j_p = j+1;
    if j == n
        j_p = 1;
    end
    
    j_m = j-1;
    if j == 1
        j_m = n;
    end
    
    if i_p == j_m
        new_L_tmp = L + D(visited_cities(i), visited_cities(j))+ D(visited_cities(i_p), visited_cities(j_p)) - D(visited_cities(i), visited_cities(i_p)) - D(visited_cities(j), visited_cities(j_p));
    elseif j_p == i
        new_L_tmp = L + D(visited_cities(j_m), visited_cities(i))+ D(visited_cities(j), visited_cities(i_p)) - D(visited_cities(j_m), visited_cities(j)) - D(visited_cities(i), visited_cities(i_p));
    else
        new_L_tmp = L + D(visited_cities(i), visited_cities(j)) + D(visited_cities(j), visited_cities(i_p)) + D(visited_cities(j_m), visited_cities(j_p)) - D(visited_cities(i), visited_cities(i_p)) - D(visited_cities(j_m), visited_cities(j)) - D(visited_cities(j), visited_cities(j_p));
    end
    if new_L_tmp <= L
        L = new_L_tmp;
        ind = 1 : n+1;
        if i < j
            ind = [ind(1:i), j, ind(i+1:j-1), ind(j+1:end)];
        else
            ind = [ind(1:j-1), ind(j+1:i), j, ind(i+1:end)];
        end
        visited_cities = visited_cities(ind);
    end
    Lvec(k) = L;
    

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    else % inversion
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        i = 1+floor(rand()*n);
    
    i_p = i+1;
    if i == n
        i_p = 1;
    end
    
    i_m = i-1;
    if i == 1
        i_m = n;
    end
    
    j = 1+floor(rand()*n);
    
    while (j == i || j==i_p || j==i_m)
        j = 1+floor(rand()*n);
    end
    if i < j
        
        j_p = j+1;
        if j == n
            j_p = 1;
        end
        if j_p>=n+1
            disp('slam');
        end
        
        new_L_tmp = L + D(visited_cities(i), visited_cities(j))+ D(visited_cities(i_p), visited_cities(j_p)) - D(visited_cities(i), visited_cities(i_p)) - D(visited_cities(j), visited_cities(j_p));
        
        if new_L_tmp <= L
            L = new_L_tmp;
            ind = 1 : n+1;
            ind = [ind(1:i), ind(j:-1:i+1), ind(j+1:end)];
            visited_cities = visited_cities(ind);
        end
    end
    Lvec(k) = L;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    end
end
new_visited_cities = visited_cities;
new_visited_cities = [new_visited_cities; new_visited_cities(1)];
new_L = L;
end

    
        