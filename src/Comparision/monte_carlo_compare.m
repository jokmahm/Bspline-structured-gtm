function [N_l, N_h, A3] = monte_carlo_compare(cluster_idx, GT2)
    global model
    year_start = model.year_start;

    s = load('data_N32.mat');
    d = load('data_C32');
    b = load('data_B.mat'); % Load biomass data

    year_finish = 2017;
    y_values = year_start:year_finish;
    num_years = numel(y_values);
    num_samples = 100; % Monte Carlo simulations

    % Identify indices for clusters
    idx_cluster1 = find(cluster_idx == 1);
    idx_cluster2 = find(cluster_idx == 2);

    % Initialize storage for Monte Carlo results
    norm_diff_Nl_samples = zeros(num_samples, num_years);
    norm_diff_Nh_samples = zeros(num_samples, num_years);

    for i = 1:num_years
        y = y_values(i);

        [~, a2, ~, ~] = Initial_Data(y);
        [~,~,A3,~,~,~,~,~] = Initial_Data_new(y+1);
        
        rng(12345); % Set the seed to a fixed number (e.g., 1234)

        % Monte Carlo Simulation
        for j = 1:num_samples
            % Randomly select a matrix from the corresponding cluster
            rand_G_l = GT2(:, :, idx_cluster1(randi(numel(idx_cluster1))));
            rand_G_h = GT2(:, :, idx_cluster2(randi(numel(idx_cluster2))));

            % Project population
            N_l(:, i, j) = rand_G_l * a2;  
            N_h(:, i, j) = rand_G_h * a2;  

            % Compute norms
            norm_diff_Nl_samples(j, i) = norm(A3 - N_l(:, i, j));
            norm_diff_Nh_samples(j, i) = norm(A3 - N_h(:, i, j));
        end
    end

    % Extract total biomass and age-3 biomass from data_B
    initial_index = year_start - 1971;
    total_biomass = b.data_B(5, initial_index - 1 : initial_index + num_years - 2);
    age3_biomass = b.data_B(3, initial_index - 1 : initial_index + num_years - 2);

    % Normalize values
    max_total_biomass = max(total_biomass);
    max_age3_biomass = max(age3_biomass);

    norm_total_biomass = total_biomass / max_total_biomass;
    norm_age3_biomass = age3_biomass / max_age3_biomass;

    % Normalize norm differences across all samples
    max_norm_diffs = max([norm_diff_Nl_samples(:); norm_diff_Nh_samples(:)]);
    norm_diff_Nl_samples = norm_diff_Nl_samples / max_norm_diffs;
    norm_diff_Nh_samples = norm_diff_Nh_samples / max_norm_diffs;

    % Compute mean and bounds for shading
    mean_Nl = mean(norm_diff_Nl_samples, 1);
    mean_Nh = mean(norm_diff_Nh_samples, 1);
    std_Nl = std(norm_diff_Nl_samples, 0, 1);
    std_Nh = std(norm_diff_Nh_samples, 0, 1);

    % Upper and lower bounds for shading

    %upper_Nl = mean_Nl + std_Nl;
    %lower_Nl = mean_Nl - std_Nl;
    %upper_Nh = mean_Nh + std_Nh;
    %lower_Nh = mean_Nh - std_Nh;

    upper_Nl = prctile(mean_Nl + std_Nl, 97.5,1);
    lower_Nl = prctile(mean_Nl - std_Nl, 2.5,1);
    upper_Nh = prctile(mean_Nh + std_Nh, 97.5,1);
    lower_Nh = prctile(mean_Nh - std_Nh, 2.5,1);

    %% **First Plot: Total Biomass vs. Norm Differences**
    figure;
    yyaxis left;
    plot(y_values, norm_total_biomass, '-o', 'LineWidth', 2, 'Color', 'blue'); % Blue line for total biomass
    ylabel('Normalized Total Biomass', 'FontWeight', 'bold');
    xlabel('Year', 'FontWeight', 'bold');

    yyaxis right;
    hold on;
    fill([y_values, fliplr(y_values)], [upper_Nl, fliplr(lower_Nl)], 'magenta', 'FaceAlpha', 0.2, 'EdgeColor', 'none'); % Shaded region for ||A_3 - N_l||
    fill([y_values, fliplr(y_values)], [upper_Nh, fliplr(lower_Nh)], 'red', 'FaceAlpha', 0.2, 'EdgeColor', 'none'); % Shaded region for ||A_3 - N_h||
    plot(y_values, mean_Nl, '--s', 'LineWidth', 1, 'Color', 'magenta', 'MarkerFaceColor', 'magenta'); % Mean line for ||A_3 - N_l||
    plot(y_values, mean_Nh, '--^', 'LineWidth', 1, 'Color', 'red', 'MarkerFaceColor', 'red'); % Mean line for ||A_3 - N_h||
    ylabel('Normalized Error in Norm', 'FontWeight', 'bold');
    
    lgd = legend('Total Biomass', 'Err(cluster 1)', 'Err(cluster 2)', 'Location', 'best');
    set(lgd, 'FontWeight', 'bold'); % Make the legend text bold

    ax = gca; % Get current axis
    set(ax, 'FontWeight', 'bold'); % Apply bold font to all axis labels

    grid on;
    box off;

    %% **Second Plot: Age-3 Biomass vs. Norm Differences**
    figure;
    yyaxis left;
    plot(y_values, norm_age3_biomass, '-o', 'LineWidth', 2, 'Color', 'blue'); % Blue line for Age-3 Biomass
    ylabel('Normalized Age-3 Biomass');
    xlabel('Year');

    yyaxis right;
    hold on;
    fill([y_values, fliplr(y_values)], [upper_Nl, fliplr(lower_Nl)], 'magenta', 'FaceAlpha', 0.2, 'EdgeColor', 'none'); % Shaded region for ||A_3 - N_l||
    fill([y_values, fliplr(y_values)], [upper_Nh, fliplr(lower_Nh)], 'red', 'FaceAlpha', 0.2, 'EdgeColor', 'none'); % Shaded region for ||A_3 - N_h||
    plot(y_values, mean_Nl, '--s', 'LineWidth', 1, 'Color', 'magenta', 'MarkerFaceColor', 'magenta'); % Mean line for ||A_3 - N_l||
    plot(y_values, mean_Nh, '--^', 'LineWidth', 1, 'Color', 'red', 'MarkerFaceColor', 'red'); % Mean line for ||A_3 - N_h||
    ylabel('Normalized Differences in norms');
    
    legend('Age-3 Biomass', 'Err(cluster 1)', 'Err(cluster 2)', 'Location', 'best')
    grid off;
    box off;

end
