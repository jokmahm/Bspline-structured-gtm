function MortalityPlot(years,M2)

global model
year_start = model.year_start;
initial_index = year_start - 1971;

load('data_B.mat');

% Plot 1: Mortality rate M2(1,:) and Biomass data_B(5,28:43)
figure;
% Plot the first curve on the left y-axis
yyaxis left;
plot(years, M2(1, :), 'b-', 'LineWidth', 2);
ylabel('Mortality rate');  % Customize the label as needed
% Activate the right y-axis and plot the second curve
yyaxis right;
plot(years, data_B(5, initial_index:length(years)+initial_index-1), 'r-', 'LineWidth', 2);
ylabel('Biomass');  % Customize the label as needed
% Add common x-axis label
xlabel('Year');
% Add a title
title('Mortality rate (5-9cm) vs Caplin biomass');

% Plot 2: Mortality rate M2(2,:) and Biomass data_B(5,28:43)
figure;
% Plot the first curve on the left y-axis
yyaxis left;
plot(years, M2(2, :), 'b-', 'LineWidth', 2);
ylabel('Mortality rate');  % Customize the label as needed
% Activate the right y-axis and plot the second curve
yyaxis right;
plot(years, data_B(5, initial_index:length(years)+initial_index-1), 'r-', 'LineWidth', 2);
ylabel('Biomass');  % Customize the label as needed
% Add common x-axis label
xlabel('Year');
% Add a title
title('Mortality rate (9-17cm) vs Caplin biomass');

% Plot 3: Mortality rate M2(3,:) and Biomass data_B(5,28:43)
figure;
% Plot the first curve on the left y-axis
yyaxis left;
plot(years, M2(3, :), 'b-', 'LineWidth', 2);
ylabel('Mortality rate');  % Customize the label as needed
% Activate the right y-axis and plot the second curve
yyaxis right;
plot(years, data_B(5, initial_index:length(years)+initial_index-1), 'r-', 'LineWidth', 2);
ylabel('Biomass');  % Customize the label as needed
% Add common x-axis label
xlabel('Year');
% Add a title
title('Mortality rate (17-21cm) vs Caplin biomass');

% Customize the appearance further if necessary
grid on;


% Plot 4: Mortality rate M2(1,:) 
figure;
plot(years, M2(1, :), 'b-', 'LineWidth', 2);
ylabel('Mortality rate');  % Customize the label as needed
xlabel('Year');
grid off;
box(gca,'off');

% Plot 5: Mortality rate M2(2,:)
figure;
plot(years, M2(2, :), 'b-', 'LineWidth', 2);
ylabel('Mortality rate');  % Customize the label as needed
xlabel('Year');
grid off;
box(gca,'off');

% Plot 6: Mortality rate M2(3,:) 
figure;
plot(years, M2(3, :), 'b-', 'LineWidth', 2);
ylabel('Mortality rate');  % Customize the label as needed
xlabel('Year');
grid off;
box(gca,'off');