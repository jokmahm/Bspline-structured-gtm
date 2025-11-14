% Assuming your data matrix is named GT with dimensions 15x32
GT = zeros(16,32);

for i=1:16
    GT(i,:) = sum(GT1(:,:,i),2);
end

% Define a range of values for k (number of clusters)
k_values = 1:10;

% Initialize an array to store the sum of squared distances for each k
sum_of_squared_distances = zeros(size(k_values));

% Perform k-means clustering for each value of k and calculate the sum of squared distances
for k = k_values
    [~, ~, sumd] = kmeans(GT, k);
    sum_of_squared_distances(k) = sum(sumd);
end

% Use the elbow method to find the optimal value of k
figure;
plot(k_values, sum_of_squared_distances, 'o-');
xlabel('Number of Clusters (k)');
ylabel('Sum of Squared Distances');
title('Elbow Method for Optimal k');
grid on;

% Manually select the elbow point or use an automated method
% For simplicity, you can manually set the optimal value of k based on the plot

% Set the optimal value of k
optimal_k = input('Enter the optimal value of k: ');



% Set a random seed for reproducibility
rng(1); % You can use any integer value as the seed



% Perform k-means clustering with the optimal value of k
[idx, centers] = kmeans(GT, optimal_k);

% Plot the vectors in each cluster
%figure;
%for i = 1:optimal_k
    %subplot(optimal_k, 1, i);
    %cluster_indices = find(idx == i);
    %plot(GT(cluster_indices, :)', 'LineWidth', 2);
    %title(['Cluster ', num2str(i)]);
%end

% Create a figure for plotting
figure;

% Plot the vectors in each cluster
for i = 1:optimal_k
    subplot(optimal_k, 1, i);
    
    % Get indices of vectors in the current cluster
    cluster_indices = find(idx == i);
    
    % Plot the vectors
    plot(GT(cluster_indices, :)', 'LineWidth', 2);
    
    % Find the index of the maximum value in each vector
    [~, max_indices] = max(GT(cluster_indices, :), [], 2);
    
    % Find the average index value
    avg_index = mode(max_indices);
    
    % Plot a line indicating the average index value
    hold on;
    plot([avg_index, avg_index], ylim, '--r', 'LineWidth', 2);
    
    title(['Cluster ', num2str(i)]);
    hold off;
end

% Adjust the layout
xlabel('Vector Index');


% Assuming you have already performed k-means clustering and obtained the cluster indices 'idx'

% Number of clusters
k = max(idx);

% Create a time series with cluster assignments
time_series = zeros(16, 1);

for i = 1:k
    time_series(idx == i) = i;
end

% Assuming you have the time series 'time_series' and the data 'data_B(5,28:43)'

% Years 1999 to 2014
years = 1999:2014;
load('data_B.mat')

% Create a figure
figure;

% Plot the data_B(2,28:43) curve
plot(years, data_B(2,28:43), 'o-', 'LineWidth', 1);
xlabel('Year');
ylabel('Fish Biomass');
title('Age 2 Fish Biomass Data');

% Add text labels for cluster assignments at each year
for i = 1:numel(years)
    text(years(i), data_B(2, 27+i), num2str(idx(i)), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'center', 'FontSize', 10, 'FontWeight', 'bold', 'Color', 'red');
end

grid on;


% another plot for total biomass
% Create a figure
figure;

% Plot the data_B(5,28:43) curve
plot(years, data_B(5,28:43), 'o-', 'LineWidth', 1);
xlabel('Year');
ylabel('Fish Biomass');
title('Total Fish Biomass Data');

% Add text labels for cluster assignments at each year
for i = 1:numel(years)
    text(years(i), data_B(5, 27+i), num2str(idx(i)), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'center', 'FontSize', 10, 'FontWeight', 'bold', 'Color', 'red');
end

grid on;