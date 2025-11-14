function [N_l, N_h, A3] = compare(cluster_idx, GT2)
    global model
    x_mid = model.x_mid;
    year_start = model.year_start;

    [G_l, G_h] = calculate_average_matrices(GT2, cluster_idx);

    figure(1)
    plot(sum(G_l,2), 'LineWidth', 2, 'Color', [0.5 0 0.5])
    hold on
    plot(sum(G_h,2), 'LineWidth', 2, 'Color', [0.9 0.4 0])
    grid on
    xlabel('Length class');
    ylabel('Accumulated growth transition');
    legend('G_{low}', 'G_{high}');
    hold off;
    grid off;
    box(gca, 'off');

    s = load('data_N32.mat');
    d = load('data_C32');
    b = load('data_B.mat'); % Load biomass data

    year_finish = 2017;
    y_values = year_start:year_finish-1;

    num_years = numel(y_values);
    norm_AA3 = zeros(1, num_years);
    norm_diff_Nl = zeros(1, num_years);
    norm_diff_Nh = zeros(1, num_years);

    for i = 1:num_years
        y = y_values(i);

        [~, a2, ~, ~] = Initial_Data(y);
        [~,~,A3,~,~,C2,~,~] = Initial_Data_new(y+1);

        % Project population
        N_l(:, i) = G_l * a2; 
        N_h(:, i) = G_h * a2;
        AA3(:, i) = A3;

        % Compute norms
        norm_AA3(i) = norm(A3);
        norm_diff_Nl(i) = norm(A3 - N_l(:, i));
        norm_diff_Nh(i) = norm(A3 - N_h(:, i));
    end

    % Extract total biomass and age-3 biomass from data_B
    initial_index = year_start - 1971;
    total_biomass = b.data_B(5, initial_index - 1 : initial_index + num_years - 2);
    age3_biomass = b.data_B(3, initial_index - 1 : initial_index + num_years - 2);

    % Normalize values
    max_norm_diffs = max([norm_diff_Nl, norm_diff_Nh]);
    max_total_biomass = max(total_biomass);
    max_age3_biomass = max(age3_biomass);

    norm_total_biomass = total_biomass / max_total_biomass;
    norm_age3_biomass = age3_biomass / max_age3_biomass;
    norm_diff_Nl_scaled = norm_diff_Nl / max_norm_diffs;
    norm_diff_Nh_scaled = norm_diff_Nh / max_norm_diffs;

    %% **First Plot: Total Biomass vs. Norm Differences**
    figure;
    yyaxis left;
    plot(y_values, norm_total_biomass, '-o', 'LineWidth', 2, 'Color', 'blue'); % Blue line for Age-3 Biomass
    ylabel('Normalized capelin total Biomass');
    xlabel('Year');

    yyaxis right;
    plot(y_values, norm_diff_Nl_scaled, '--s', 'LineWidth', 1, 'Color', 'magenta'); % Light red dashed line with square markers for ||A_3 - N_l||
    hold on;
    plot(y_values, norm_diff_Nh_scaled, '--^', 'LineWidth', 1, 'Color', 'red'); % Light yellow dashed line with triangle markers for ||A_3 - N_h||
    ylabel('Normalized Differences in norms');
    
    legend({'Total Biomass', '$\|N_{3,y}-\hat{N}_{3,y}^{low}\|\ $', '$\|N_{3,y}-\hat{N}_{3,y}^{high}\|\ $'}, ...
       'Location', 'best', 'Interpreter', 'latex')
    grid on;
    box on;

    %% **Second Plot: Age-3 Biomass vs. Norm Differences**
    figure;
    yyaxis left;
    plot(y_values, norm_age3_biomass, '-o', 'LineWidth', 2, 'Color', 'blue'); % Green line for Age-3 Biomass
    ylabel('Normalized Age-3 Biomass');
    xlabel('Year');

    yyaxis right;
    plot(y_values, norm_diff_Nl_scaled, '--s', 'LineWidth', 1, 'Color','magenta'); % Light red dashed line with square markers for ||A_3 - N_l||
    hold on;
    plot(y_values, norm_diff_Nh_scaled, '--^', 'LineWidth', 1, 'Color', 'red'); % Light yellow dashed line with triangle markers for ||A_3 - N_h||
    ylabel('Normalized Differences in norms');
    
    legend({'Age-3 Biomass', '$\|N_{3,y}-\hat{N}_{3,y}^{low}\|\ $', '$\|N_{3,y}-\hat{N}_{3,y}^{high}\|\ $'}, ...
       'Location', 'best', 'Interpreter', 'latex')
    grid on;
    box on;

end


