function testGPT(start, year, x, N3)
    s = load('data_N32.mat');
    n3 = s.data_N32(:, 3, year - 1972);
    n3 = n3 / max(n3);
    
    figure('Color', 'w'); % Set background color to white
    bar(x, n3, 'FaceColor', [0.7 0.7 0.7], 'EdgeColor', 'none'); % Use light gray bars
    hold on;
    plot(x, N3(:, year - start), 'b-', 'LineWidth', 2); % Adjust line width
    xlabel('Length'); 
    ylabel('Normalized fish abundance');
    legend('Empirical data', 'Estimated by Model', 'Location', 'northwest', 'FontSize', 10); % Increase legend font size
    ylim([0 1.05]);
    title(sprintf('Year: %d', year - 1), 'FontSize', 12); % Increase title font size

    ax = gca;
    ax.FontSize = 10; % Increase axis label and tick font size
    ax.GridLineStyle = '-'; % Set grid line style
    ax.GridAlpha = 0.3; % Set grid transparency
    box off; % Remove box around plot
end
