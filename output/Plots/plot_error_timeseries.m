function plot_error_timeseries(Err_bs, Err_nA, Err_gam, Err_lgn, years)
    if nargin<5, years = (1989:2017); end
    figure('Color','w'); hold on;
    plot(years, Err_bs,  '-o', 'LineWidth',1.8, 'MarkerSize',4.5);
    plot(years, Err_nA,  '--s','LineWidth',1.8, 'MarkerSize',4.5);
    plot(years, Err_gam, ':^', 'LineWidth',2.0, 'MarkerSize',4.5);
    plot(years, Err_lgn, '-.d','LineWidth',1.8, 'MarkerSize',4.5);
    grid on; xlabel('Year'); ylabel('L2 error');
    legend({'B-spline','Normal','Gamma','Log-Normal'},'Location','best');
    title('Projection error by year');
end
