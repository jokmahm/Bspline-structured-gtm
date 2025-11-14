function residual_heatmap(N_obs, Nhat, years)
    if nargin<3, years = (1989:2017); end
    R = Nhat(:,2:end) - N_obs(:,2:end);  % residuals for plotted years
    figure('Color','w');
    imagesc(R); axis tight; colorbar;
    xlabel('Year index'); ylabel('Length class');
    title('Residuals (predicted - observed)');
    set(gca,'XTick',1:numel(years),'XTickLabel',years,'XTickLabelRotation',90);
end
