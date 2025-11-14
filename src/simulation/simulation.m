function [N_l,N_h,A3] = simulation(cluster_idx, GT2)

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
    %title('Distribution of accumulated growth into length classes');
    legend('G_{low}', 'G_{high}');
    hold off;
    grid off;
    box(gca,'off');
    
    s = load('data_N32.mat');
    d = load('data_C32');

    y_values = [1989,1997,2007,1991,2001,2011];

   

    for i = 1:numel(y_values)
        
        y = y_values(i);

        [~, a2, ~, ~] = Initial_Data(y);
        [~,~,A3,~,~,C2,~,~] = Initial_Data_new(y+1);

        % parameter estimation

        [p1,p2,m1,m2,m3,fval,exitflag] = optim_fun_simulation(a2,A3,C2,G_l);
        Survived = a2.*(1-maturity(p1,p2));
        Mortality = mortality(m1,m2,m3);
        N_l = G_l*((exp(-6*Mortality).*Survived-C2).*exp(-6*Mortality));
        N_l(N_l<0) = 0;


        [p1,p2,m1,m2,m3,fval,exitflag] = optim_fun_simulation(a2,A3,C2,G_h);
        Survived = a2.*(1-maturity(p1,p2));
        Mortality = mortality(m1,m2,m3);
        N_h = G_h*((exp(-6*Mortality).*Survived-C2).*exp(-6*Mortality));
        N_h(N_h<0) = 0;


        figure();

         % Plot A3 as bars
         %bar(A3);
         bar(A3, 'FaceColor', [0.7 0.7 0.7], 'EdgeColor', 'none'); % Use light gray bars
         hold on;

         % Plot N_l and N_h as lines
         plot(N_l, 'LineWidth', 2, 'Color', [0.5 0 0.5]); % Purple
         plot(N_h, 'LineWidth', 2, 'Color', [0.9 0.4 0]); % Orange

         % Add labels and legend
         xlabel('Length');
         ylabel('Normalized population abundance');
         title(num2str(y));
         legend('A3', 'N_{low}', 'N_{high}', 'Location', 'northwest');
         grid off;
         box(gca,'off');

         % compare values
         N_l = sum(N_l);
         N_h = sum(N_h);
         A3 = sum(A3);
    end
end