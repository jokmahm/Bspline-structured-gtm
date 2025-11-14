function [N_l,N_h,A3] = simulation_means(cluster_idx, GT2, M2, y)
    % No estimatin !
    
    global model
    x_mid = model.x_mid;
    year_start = model.year_start;

    [G_l, G_h] = calculate_average_matrices(GT2, cluster_idx);

    figure(1)
    plot(sum(G_l,2), 'LineWidth', 2)
    hold on
    plot(sum(G_h,2), 'LineWidth', 2)
    grid on
    xlabel('length class');
    ylabel('density');
    title('Distribution of accumulated growth into length classes');
    legend('G_{low}', 'G_{high}');
    hold off;
    
    s = load('data_N32.mat');
    d = load('data_C32');
    %a2 = s.data_N32(:,2,y-1971);
    %A3 = s.data_N32(:,2,y+1-1971);
    %C2 = d.data_C32(:,2,y+1-1971);

    y_values = [1989,1997,2007,1994,2001,2011];

    % Create a figure with a 2x3 subplot grid
    figure(2);

    for i = 1:numel(y_values)
        
        y = y_values(i);

        [~, a2, ~, ~] = Initial_Data(y);
        [~,~,A3,~,~,C2,~,~] = Initial_Data_new(y+1);

        % maturity
        [P1,P2] = MaturityData();
        p1 = P1(y-1971);
        p2 = P2(y-1971);
        maturity = 1./(1+exp(4*p1*(p2-x_mid)));
        maturity = maturity';

        % mortality
        m1 = M2(1,y-year_start+1);
        m2 = M2(2,y-year_start+1);
        m3 = M2(3,y-year_start+1);

        Survived = a2.*(1-maturity);
        Mortality = mortality(m1,m2,m3);
        N_l = G_l*((exp(-6*Mortality).*Survived-C2).*exp(-6*Mortality));
        N_l(N_l<0) = 0;
        N_h = G_h*((exp(-6*Mortality).*Survived-C2).*exp(-6*Mortality));
        N_h(N_h<0) = 0;

        N_l = N_l/max(N_l)*max(A3);
        N_h = N_h/max(N_h)*max(A3);

        subplot(2, 3, i);

         % Plot A3 as bars
         bar(A3);
         hold on;

         % Plot N_l and N_h as lines
         plot(N_l, 'LineWidth', 2);
         plot(N_h, 'LineWidth', 2);

         % Add labels and legend
         xlabel('Length class');
         ylabel('Population abundance');
         title('Distribution Comparison year ', num2str(y));
         legend('A3', 'N_l', 'N_h', 'Location', 'northwest');
          grid on;

          % compare values
          N_l = sum(N_l);
          N_h = sum(N_h);
          A3 = sum(A3);
    end
end