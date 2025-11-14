function SumMortalityPlot(years,M2)

global model
year_start = model.year_start;
initial_index = year_start - 1971;

load('data_B.mat');

M = sum(M2);

% Plot 1: Mortality rate M2(1,:) and Biomass data_B(5,28:43)
figure;
% Plot the first curve on the left y-axis
yyaxis left;
plot(years, M(1, :), 'b-', 'LineWidth', 2);
ylabel('Mortality rate');  % Customize the label as needed
% Activate the right y-axis and plot the second curve
yyaxis right;
plot(years, data_B(5, initial_index:length(years)+initial_index-1), 'r-', 'LineWidth', 2);
ylabel('Biomass');  % Customize the label as needed
% Add common x-axis label
xlabel('Year');
% Add a title
title('Sum mortality rate over all length intervals vs Caplin biomass');

% Customize the appearance further if necessary
grid on;