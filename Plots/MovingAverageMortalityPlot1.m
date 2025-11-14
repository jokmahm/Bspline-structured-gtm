function MovingAverageMortalityPlot1(years, M2, movingAverageWindow)

global model
year_start = model.year_start;
initial_index = year_start - 1971;

load('data_B.mat');

% Calculate moving averages for each M2 vector
%movingAvgM2 = movmean(M2, movingAverageWindow, 2, 'Endpoints', 'discard');
movingAvgM2 = movmean(M2, movingAverageWindow, 2);

% Plot the moving averages against Biomass data_B(5,28:43)
for i = 1:size(M2, 1)
    figure;
    
    % Plot the moving average curve on the left y-axis
    yyaxis left;
    %plot(years(movingAverageWindow:end), movingAvgM2(i, :), 'b-', 'LineWidth', 2);
    plot(years, movingAvgM2(i, :), 'b-', 'LineWidth', 2);
    ylabel('Moving Average Mortality rate');  % Customize the label as needed
    
    % Activate the right y-axis and plot the Biomass curve
    yyaxis right;
    plot(years, data_B(3, initial_index:length(years)+initial_index-1), 'r-', 'LineWidth', 2);
    ylabel('Biomass');  % Customize the label as needed
    
    % Add common x-axis label
    xlabel('Year');
    
    % Add a title
    title(['Moving Average Mortality rate vs Caplin biomass (m' num2str(i) ')']);
    
    % Customize the appearance further if necessary
    grid on;
end


M = mean(M2);

% Calculate moving averages for each M2 vector
%movingAvgM = movmean(M, movingAverageWindow, 2, 'Endpoints', 'discard');
movingAvgM = movmean(M, movingAverageWindow, 2);

% Plot the moving averages against Biomass data_B(5,28:43)
figure;
    
% Plot the moving average curve on the left y-axis
yyaxis left;
%plot(years(movingAverageWindow:end), movingAvgM, 'b-', 'LineWidth', 2);
plot(years, movingAvgM, 'b-', 'LineWidth', 2);
ylabel('Moving Average mean Mortality rate');  % Customize the label as needed
    
% Activate the right y-axis and plot the Biomass curve
yyaxis right;
plot(years, data_B(3, initial_index:length(years)+initial_index-1), 'r-', 'LineWidth', 2);
ylabel('Biomass');  % Customize the label as needed
    
% Add common x-axis label
xlabel('Year');
    
% Add a title
title(['Moving Average mean Mortality rate vs Caplin biomass']);
    
% Customize the appearance further if necessary
grid on;
end
