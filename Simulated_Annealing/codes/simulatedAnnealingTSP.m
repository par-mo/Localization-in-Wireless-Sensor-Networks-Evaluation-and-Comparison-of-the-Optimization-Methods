function [new_visited_cities, new_L, Lvec] = simulatedAnnealingTSP(X, Y, visited_cities, L, SA_option)

T0 = 10000;
b = 0.99;
iter_per_temp = 5000;
total_iter = 5000*1000;

n = length(X);
D = constructDistanceMatrix(X,Y);

switch SA_option
    case 'metropolis'
        [new_visited_cities, new_L, Lvec] = simulatedAnnealingMetropolis(D, visited_cities, L, T0, b, iter_per_temp, total_iter);
    case 'heat bath'
        [new_visited_cities, new_L, Lvec] = simulatedAnnealingHeatBath(D, visited_cities, L, T0, b, iter_per_temp, total_iter);
    otherwise
        error('option not valid');
end
end


function [new_visited_cities, new_L, Lvec] = simulatedAnnealingMetropolis(D, visited_cities, L, T0, b, iter_per_temp, total_iter)

n = length(D);

Lvec = zeros(floor(total_iter/iter_per_temp)-1, 1);

T = T0;
iter_ind = 1;
temp_iter_ind = 1;
Lvec_temp = zeros(iter_per_temp, 1);

temp_round_ind = 1;
while iter_ind < total_iter
    
    [swapped_cities, L_swapped] = swapCities(D, visited_cities, L);
    prob = exp(-(L_swapped - L)/T);
    if L_swapped < L
        visited_cities = swapped_cities;
        L = L_swapped;
    elseif rand() < prob
        visited_cities = swapped_cities;
        L = L_swapped;
    end
    Lvec_temp(temp_iter_ind) = L;
    
    temp_iter_ind = temp_iter_ind + 1;
    iter_ind = iter_ind + 1;
    
    if temp_iter_ind > iter_per_temp
        T = T * b;
        temp_iter_ind = 1;
        Lvec(temp_round_ind) = min(Lvec_temp);
        Lvec_temp = zeros(iter_per_temp, 1);
        temp_round_ind = temp_round_ind + 1;
    end
    
    
end
new_visited_cities = visited_cities;
new_L = L;
end

function [new_visited_cities, new_L, Lvec] = simulatedAnnealingHeatBath(D, visited_cities, L, T0, b, iter_per_temp, total_iter);

n = length(D);

Lvec = zeros(floor(total_iter/iter_per_temp)-1, 1);

T = T0;
iter_ind = 1;
temp_iter_ind = 1;
Lvec_temp = zeros(iter_per_temp, 1);

temp_round_ind = 1;
while iter_ind < total_iter
    
    [swapped_cities, L_swapped] = swapCities(D, visited_cities, L);
    prob = 1/(1+exp((L_swapped - L)/T));
    if rand() < prob
        visited_cities = swapped_cities;
        L = L_swapped;
    end
    Lvec_temp(temp_iter_ind) = L;
    
    temp_iter_ind = temp_iter_ind + 1;
    iter_ind = iter_ind + 1;
    
    if temp_iter_ind > iter_per_temp
        T = T * b;
        temp_iter_ind = 1;
        Lvec(temp_round_ind) = min(Lvec_temp);
        Lvec_temp = zeros(iter_per_temp, 1);
        temp_round_ind = temp_round_ind + 1;
    end
    
    
end
new_visited_cities = visited_cities;
new_L = L;
end


function [swapped_cities, L_swapped] = swapCities(D, visited_cities, L)

n = length(D);

i = 1+floor(rand()*n);
j = 1+floor(rand()*n);
while (abs(j - i) > 10 || j == i)
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
    L_swapped = L + D(visited_cities(i_m), visited_cities(j))+ D(visited_cities(i), visited_cities(j_p)) - D(visited_cities(i_m), visited_cities(i)) - D(visited_cities(j), visited_cities(j_p));
elseif j_p == i
    L_swapped = L + D(visited_cities(j_m), visited_cities(i))+ D(visited_cities(j), visited_cities(i_p)) - D(visited_cities(j_m), visited_cities(j)) - D(visited_cities(i), visited_cities(i_p));
else
    L_swapped = L + D(visited_cities(i_m), visited_cities(j)) + D(visited_cities(j), visited_cities(i_p)) + D(visited_cities(j_m), visited_cities(i)) + D(visited_cities(i), visited_cities(j_p)) - D(visited_cities(i_m), visited_cities(i)) - D(visited_cities(i), visited_cities(i_p)) - D(visited_cities(j_m), visited_cities(j)) - D(visited_cities(j), visited_cities(j_p));
end
ind = 1 : n+1;
ind(i) = j;
ind(j) = i;
swapped_cities = visited_cities(ind);

end