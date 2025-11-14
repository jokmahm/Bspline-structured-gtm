function [G_l_normalized, G_h_normalized] = calculate_average_matrices(GT2, cluster_index)

% Extract the dimensions of GT2
[~, ~, num_years] = size(GT2);

% Initialize matrices to store averages for each group
G_l = zeros(32, 32);
G_h = zeros(32, 32);

% Iterate over each year
for i = 1:num_years
    % Check if the cluster index corresponds to group 1
    if cluster_index(i) == 1
        % Add the matrix at this year to the group 1 average
        G_l = G_l + GT2(:, :, i);
    % Check if the cluster index corresponds to group 2
    elseif cluster_index(i) == 2
        % Add the matrix at this year to the group 2 average
        G_h = G_h + GT2(:, :, i);
    end
end

% Calculate the average for each group
% Divide by the number of years in each group
num_years_l = sum(cluster_index == 1);
num_years_h = sum(cluster_index == 2);

G_l = G_l / num_years_l;
G_h = G_h / num_years_h;

% Normalize columns of G_l
column_sums_l = sum(G_l);
G_l_normalized = G_l ./ column_sums_l;

% Normalize columns of G_h
column_sums_h = sum(G_h);
G_h_normalized = G_h ./ column_sums_h;

end
