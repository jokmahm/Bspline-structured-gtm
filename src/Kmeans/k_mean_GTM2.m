function idx = k_mean_GTM2(GT2,years)

global model
year_start = model.year_start;
initial_index = year_start - 1971;

[~,~,n3] = size(GT2);

% Assuming your data matrix is named GT with dimensions 15x32
GT = zeros(n3,32);

% Sum over al transitions INTO length class i
for i=1:n3
    GT(i,:) = sum(GT2(:,:,i),2);  
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
%title('Elbow Method for Optimal k');
grid off;
box(gca,'off');

% Manually select the elbow point or use an automated method
% For simplicity, you can manually set the optimal value of k based on the plot

% Set the optimal value of k
%optimal_k = input('Enter the optimal value of k: ');
optimal_k = 2;

% Set a random seed for reproducibility
rng(100); % You can use any integer value as the seed

% Perform k-means clustering with the optimal value of k
[idx, centers] = kmeans(GT, optimal_k);

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
    avg_index = mean(max_indices);
    
    % Plot a line indicating the average index value
    hold on;
    plot([avg_index, avg_index], ylim, '--r', 'LineWidth', 2);
    
    title(['Cluster ', num2str(i)]);
    hold off;
    box(gca,'off');
end

% Adjust the layout
xlabel('Lenght class');

% Assuming you have already performed k-means clustering and obtained the cluster indices 'idx'

% Number of clusters
k = max(idx);

% Create a time series with cluster assignments
time_series = zeros(n3, 1);

for i = 1:k
    time_series(idx == i) = i;
end


% Assuming you have the time series 'time_series' and the data 'data_B(5,28:43)'

% Years 1999 to 2014
load('data_B.mat')

% Create a figure
figure;

% Plot the data_B(5,28:43) curve
plot(years, data_B(3,initial_index-1:length(years)+initial_index-2), 'o-', 'LineWidth', 1);
xlabel('Year');
ylabel('Age 3 Biomass');
%title('Age 3 Fish Biomass Data');

% Add text labels for cluster assignments at each year
for i = 1:numel(years)
    text(years(i), data_B(3, i+initial_index-2), num2str(idx(i)), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'center', 'FontSize', 10, 'FontWeight', 'bold', 'Color', 'red');
end
grid off;
box(gca,'off');


% another plot for total biomass
% Create a figure
figure;

% Plot the data_B(5,28:43) curve
plot(years, data_B(5,initial_index-1:length(years)+initial_index-2), 'o-', 'LineWidth', 1);
xlabel('Year');
ylabel('Total Biomass');
%title('Total  Fish Biomass Data');

% Add text labels for cluster assignments at each year
for i = 1:numel(years)
    text(years(i), data_B(5, i+initial_index-2), num2str(idx(i)), 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'center', 'FontSize', 10, 'FontWeight', 'bold', 'Color', 'red');
end
grid off;
box(gca,'off');
