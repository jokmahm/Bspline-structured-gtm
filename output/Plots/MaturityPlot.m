function MaturityPlot(years,P2)

global model
year_start = model.year_start;
initial_index = year_start - 1971;

load('data_B.mat');

% Plot 1: Maturity rate P2(1,:) and Biomass data_B(5,28:43)
figure;
% Plot the first curve on the left y-axis
yyaxis left;
plot(years, P2(1, :), 'b-', 'LineWidth', 2);
ylabel('Maturation intensity');  % Customize the label as needed
% Activate the right y-axis and plot the second curve
yyaxis right;
plot(years, data_B(5, initial_index:length(years)+initial_index-1), 'r-', 'LineWidth', 2);
ylabel('Biomass');  % Customize the label as needed
% Add common x-axis label
xlabel('Year');
% Add a title
title('Caplin biomass vs Maturation intensity');

% Plot 2: Maturity rate P2(2,:) and Biomass data_B(5,28:43)
figure;
% Plot the first curve on the left y-axis
yyaxis left;
plot(years, P2(2, :), 'b-', 'LineWidth', 2);
ylabel('Median length at maturity');  % Customize the label as needed
% Activate the right y-axis and plot the second curve
yyaxis right;
plot(years, data_B(5, initial_index:length(years)+initial_index-1), 'r-', 'LineWidth', 2);
ylabel('Biomass');  % Customize the label as needed
% Add common x-axis label
xlabel('Year');
% Add a title
title('Caplin biomass vs Median length at maturity');



% Plot 1: Maturity rate P2(1,:) 
figure;
plot(years, P2(1, :), 'b-', 'LineWidth', 2);
ylabel('Maturation intensity');  % Customize the label as needed
xlabel('Year');
grid off;
box(gca,'off');

% Plot 3: Maturity rate P2(2,:) 
figure;
plot(years, P2(2, :), 'b-', 'LineWidth', 2);
ylabel('Median length at maturity');  % Customize the label as needed
xlabel('Year');
grid off;
box(gca,'off');