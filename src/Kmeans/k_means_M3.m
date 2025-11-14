M = M3;

% Generate sample data
rng(1); % Set seed for reproducibility

% Define a range of cluster numbers to try
k_values = 1:10;

% Initialize an array to store the sum of squared distances for each k
sum_squared_distances = zeros(size(k_values));

% Perform k-means clustering for each k and calculate sum of squared distances
for i = 1:length(k_values)
    k = k_values(i);
    [~, ~, sumd] = kmeans(M', k);
    sum_squared_distances(i) = sum(sumd);
end

% Use the elbow method to find the optimal number of clusters (k)
figure;
plot(k_values, sum_squared_distances, 'o-');
title('Elbow Method for Optimal k');
xlabel('Number of Clusters (k)');
ylabel('Sum of Squared Distances');

% Prompt user to input the optimal value of k based on the elbow in the plot
prompt = 'Enter the optimal value of k based on the elbow in the plot: ';
optimal_k = input(prompt);

% Perform k-means clustering with the optimal value of k
[idx, ~, ~, ~] = kmeans(M', optimal_k);

% Plot vectors in each cluster in 3D with distinct colors
figure;
Mp = M';
scatter3(Mp(:,1), Mp(:,2), Mp(:,3), 16, idx, 'filled');

% Add labels and title
xlabel('m1');
ylabel('m2');
zlabel('m3');
title('3D Bar Plot of Cluster Points');

% Years from 1999 to 2014
years = 1999:2014;
load('data_B.mat')

% Extract the subset of interest (data_B(5, 28:43))
subset_data = data_B(5, 28:43);


% Plot the fish biomass data with annotations for each cluster
figure;
plot(years, subset_data, 'o-', 'LineWidth', 1);
xlabel('Year');
ylabel('Fish Biomass');
title('Fish Biomass Data with K-Means Clustering Annotations');

% Add annotations for each data point with the corresponding cluster
for i = 1:numel(years)
    text(years(i), subset_data(i), num2str(idx(i)), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom');
end
grid on;
