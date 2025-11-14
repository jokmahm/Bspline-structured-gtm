function [N_l, N_h, A3] = compare(cluster_idx, GT2)
    global model
    x_mid = model.x_mid;
    year_start = model.year_start;

    [G_l, G_h] = calculate_average_matrices(GT2, cluster_idx);

    s = load('data_N32.mat');
    d = load('data_C32');

    year_finish = 2017;
    y_values = year_start:year_finish-1;
    num_years = numel(y_values);

    norm_AA3 = zeros(1, num_years);
    norm_diff_Nl = zeros(1, num_years);
    norm_diff_Nh = zeros(1, num_years);
    
    % Classification for best fit
    best_fit = zeros(1, num_years);  % 0 for N_l, 1 for N_h

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

        % Determine best representation
        if norm_diff_Nl(i) < norm_diff_Nh(i)
            best_fit(i) = 0; % N_l is a better fit
        else
            best_fit(i) = 1; % N_h is a better fit
        end
    end

    % Plot
    figure;
    hold on;
    
    % Plot the A3 norm line
    plot(y_values, norm_AA3, '-k', 'LineWidth', 2);  % Black line for A3 norm
    
    % Overlay colored markers based on best fit classification
    scatter(y_values(best_fit == 0), norm_AA3(best_fit == 0), 80, 'r', 'filled', 'o'); % Red for N_l best
    scatter(y_values(best_fit == 1), norm_AA3(best_fit == 1), 80, 'b', 'filled', 's'); % Blue for N_h best

    xlabel('Year');
    ylabel('||A_3||');
    legend({'||A_3||', 'N_l is better', 'N_h is better'}, 'Location', 'best');
    title('Representation of A_3 Over Time: Best Fit Classification');
    grid on;
    hold off;
end
