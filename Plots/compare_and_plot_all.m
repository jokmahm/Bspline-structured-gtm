function compare_and_plot_all(N_obs, Nhat_bs, Nhat_nA, Nhat_gam, Nhat_lgn)
    [n,T] = size(N_obs);
    for t=2:T
        y  = N_obs(:,t);
        yb = Nhat_bs(:,t-1);
        yn = Nhat_nA(:,t-1);
        yg = Nhat_gam(:,t-1);
        yl = Nhat_lgn(:,t-1);

        figure('Color','w');
        bar(1:n, y, 'FaceColor',[0.8 0.85 1], 'EdgeColor','none'); hold on;
        plot(1:n, yb, '-',  'LineWidth',1.6);     % B-spline
        plot(1:n, yn, '--', 'LineWidth',1.6);     % Normal (Chen)
        plot(1:n, yg, ':',  'LineWidth',1.8);     % Gamma
        plot(1:n, yl, '-.', 'LineWidth',1.6);     % Log-Normal
        grid on; xlabel('Length class'); ylabel('Number of fish');
        legend({'Observed','B-spline','Normal (Chen)','Gamma','Log-Normal'},'Location','best');
        title(sprintf('Year %d: observed vs predicted', t));
        drawnow;
    end
end
