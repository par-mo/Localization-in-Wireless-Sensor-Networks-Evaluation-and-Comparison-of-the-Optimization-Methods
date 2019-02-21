function [new_visited_cities, new_L, Lvec] = geneticTSP(X, Y, visited_cities_mat, L_mat, mutation_option)

n = length(X);
D = constructDistanceMatrix(X, Y);
prob_mutation = 0.1;

% crossover: single point crossover, two members are randomly selected and a single point
% crossover is performed on them.
%
% mutation: the members of a generation change with mutation, swap, etc...
gen_max = 100000;

for gen_ind = 1 : gen_max
    
    [crossedOver_visited_cities_mat, crossedOver_L] = crossOver(D, visited_cities_mat, L_mat);
    
    if rand < prob_mutation
        [mutated_visited_cities_mat, mutated_L] = mutate(D, crossedOver_visited_cities_mat, crossedOver_L, mutation_option);
    else
        mutated_L = crossedOver_L;
        mutated_visited_cities_mat = crossedOver_visited_cities_mat;
    end
    
    
    Lvec(gen_ind) = min(mutated_L);
    visited_cities_mat = mutated_visited_cities_mat;
    L_mat = mutated_L;
end

[new_L, L_ind] = min(mutated_L);
new_visited_cities = mutated_visited_cities_mat(:, L_ind);
end

function [crossedOver_visited_cities_mat, crossedOver_L] = crossOver(D, visited_cities_mat, L_mat)
[L_mat, ranked_ind] = sort(L_mat, 'ascend');
visited_cities_mat = visited_cities_mat(:, ranked_ind);

n = length(D);
iter_ind = 1;
cut = randi(n);
for i = 1 : 2: size(visited_cities_mat,2);
    first_part = visited_cities_mat(1:cut, i);
    [~,member_inds] = ismember(first_part, visited_cities_mat(1:n, i+1));
    second_part = visited_cities_mat(1:n,i+1);
    second_part(member_inds) = [];
    childs1(:,iter_ind) = [first_part ; second_part; first_part(1)];
    first_part = visited_cities_mat(1:cut, i+1);
    [~,member_inds] = ismember(first_part, visited_cities_mat(1:n, i));
    second_part = visited_cities_mat(1:n,i);
    second_part(member_inds) = [];
    childs2(:,iter_ind) = [first_part ; second_part; first_part(1)];
    iter_ind = iter_ind+1;
end
childs = [childs1, childs2];

L_childs = zeros(size(visited_cities_mat,2),1);
for i = 1 : size(visited_cities_mat,2)
    for j = 1 : n
    L_childs(i) = L_childs(i) + D(childs(j,i),childs(j+1,i));
    end
end
K = length(L_mat);
L_mat = L_mat(:);
L_mat = [L_mat; L_childs];
visited_cities_mat = [visited_cities_mat, childs];
[~, L_inds] = sort(L_mat, 'ascend');
crossedOver_L = L_mat(L_inds(1:K));
crossedOver_visited_cities_mat = visited_cities_mat(:,L_inds(1:K));
end

function [mutated_visited_cities_mat, mutated_L_mat] = mutate(D, visited_cities_mat, L_mat, mutation_option)


switch mutation_option
    case 'swap',
        [mutated_visited_cities_mat, mutated_L_mat] = swapMutation(D, visited_cities_mat, L_mat);
    case 'translation',
        [mutated_visited_cities_mat, mutated_L_mat] = translationMutation(D, visited_cities_mat, L_mat);
    case 'inversion',
        [mutated_visited_cities_mat, mutated_L_mat] = inversionMutation(D, visited_cities_mat, L_mat);
    case 'all',
        [mutated_visited_cities_mat, mutated_L_mat] = allMutation(D, visited_cities_mat, L_mat);
    otherwise,
        error('option not valid');
end
end

function [new_visited_cities_mat, new_L_mat] = swapMutation(D, visited_cities_mat, L_mat)

n = length(D);
for k = 1 : length(L_mat)
    
    L = L_mat(k);
    visited_cities = visited_cities_mat(:,k);
    
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
        new_L = L + D(visited_cities(i_m), visited_cities(j))+ D(visited_cities(i), visited_cities(j_p)) - D(visited_cities(i_m), visited_cities(i)) - D(visited_cities(j), visited_cities(j_p));
    elseif j_p == i
        new_L = L + D(visited_cities(j_m), visited_cities(i))+ D(visited_cities(j), visited_cities(i_p)) - D(visited_cities(j_m), visited_cities(j)) - D(visited_cities(i), visited_cities(i_p));
    else
        new_L = L + D(visited_cities(i_m), visited_cities(j)) + D(visited_cities(j), visited_cities(i_p)) + D(visited_cities(j_m), visited_cities(i)) + D(visited_cities(i), visited_cities(j_p)) - D(visited_cities(i_m), visited_cities(i)) - D(visited_cities(i), visited_cities(i_p)) - D(visited_cities(j_m), visited_cities(j)) - D(visited_cities(j), visited_cities(j_p));
    end
        ind = 1 : n+1;
        ind(i) = j;
        ind(j) = i;
        visited_cities = visited_cities(ind);
    
new_visited_cities_mat(:,k) = visited_cities;
new_L_mat(k) = new_L;
end
end

   
