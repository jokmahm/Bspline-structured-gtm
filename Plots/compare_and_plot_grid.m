function compare_and_plot_grid(N_obs, Nhat_bs, Nhat_nA, Nhat_gam, Nhat_lgn, year0)
% Bars = observed, lines = predictions (B-spline solid, Normal --, Gamma :, LogN -.).
% Ignores first column (year0), plots years (year0+1)...end in 3x3 pages.
% Legend: one per figure (inside first subplot, top-left).
% Axes:
%   - X-axis ticks/labels only on bottom row.
%   - Y-axis label "Normalized abundance" only on left column; others hide Y tick labels.
%   - Font size for labels reduced, except on final 1x2 subplot figure.

    if nargin < 6 || isempty(year0), year0 = 1988; end

    [n, T] = size(N_obs);
    nPlots = T - 1;         % years to plot (skip first)

    clip0 = @(v) max(v, 0); % clip negatives

    groupSize = 9;
    nFull = floor(nPlots / groupSize);
    remPlots = mod(nPlots, groupSize);

    smallFS = 8;  % smaller font size

    % ---- full 3x3 pages ----
    plotIdx = 0;
    for g = 1:nFull
        figure('Color','w','Name', ...
            sprintf('Years %d–%d', year0 + plotIdx + 1, year0 + plotIdx + groupSize));

        for sp = 1:groupSize
            plotIdx = plotIdx + 1;
            t = plotIdx + 2;

            y  = clip0(N_obs(:, t));
            yb = clip0(Nhat_bs(:, t-1));
            yn = clip0(Nhat_nA(:, t-1));
            yg = clip0(Nhat_gam(:, t-1));
            yl = clip0(Nhat_lgn(:, t-1));

            ax = subplot(3,3,sp);
            hBar = bar(1:n, y, 'FaceColor',[0.8 0.85 1], 'EdgeColor','none'); hold(ax,'on');
            hBs  = plot(1:n, yb, '-',  'LineWidth',1.4);
            hN   = plot(1:n, yn, '--', 'LineWidth',1.4);
            hG   = plot(1:n, yg, ':',  'LineWidth',1.6);
            hL   = plot(1:n, yl, '-.', 'LineWidth',1.4);
            grid on; xlim([1 n]);
            title(sprintf('Year %d', year0 + t - 2));

            col_idx = mod(sp-1,3) + 1;
            row_idx = ceil(sp/3);

            % Y-axis: label only for left column
            if col_idx == 1
                ylabel('Normalized abundance','FontSize',smallFS);
            else
                set(ax,'YTickLabel',[]);
                ylabel('');
            end

            % X-axis: show only bottom row
            if row_idx < 3
                set(ax,'XTickLabel',[]);
                xlabel('');
            else
                xlabel('Length class','FontSize',smallFS);
            end

            if sp == 1
                lg = legend([hBar hBs hN hG hL], ...
                    {'Observed','B-spline','Normal','Gamma','Log-Normal'}, ...
                    'Location','northwest','Box','off');
                set(lg,'Color','none');
            end
        end
    end

    % ---- last page (if remainder) ----
    if remPlots > 0
        rows = ceil(remPlots/3); cols = min(3, remPlots);
        figure('Color','w','Name', ...
            sprintf('Years %d–%d', year0 + plotIdx + 1, year0 + plotIdx + remPlots));

        for sp = 1:remPlots
            plotIdx = plotIdx + 1;
            t = plotIdx + 1;

            y  = clip0(N_obs(:, t));
            yb = clip0(Nhat_bs(:, t-1));
            yn = clip0(Nhat_nA(:, t-1));
            yg = clip0(Nhat_gam(:, t-1));
            yl = clip0(Nhat_lgn(:, t-1));

            ax = subplot(rows, cols, sp);
            hBar = bar(1:n, y, 'FaceColor',[0.8 0.85 1], 'EdgeColor','none'); hold(ax,'on');
            hBs  = plot(1:n, yb, '-',  'LineWidth',1.4);
            hN   = plot(1:n, yn, '--', 'LineWidth',1.4);
            hG   = plot(1:n, yg, ':',  'LineWidth',1.6);
            hL   = plot(1:n, yl, '-.', 'LineWidth',1.4);
            grid on; xlim([1 n]);
            title(sprintf('Year %d', year0 + t - 1));

            col_idx = mod(sp-1, cols) + 1;
            row_idx = ceil(sp / cols);

            % Y-axis: label only for left column (normal size here)
            if col_idx == 1
                ylabel('Normalized abundance');
            else
                set(ax,'YTickLabel',[]);
                ylabel('');
            end

            % X-axis: only bottom row (normal size here)
            if row_idx < rows
                set(ax,'XTickLabel',[]);
                xlabel('');
            else
                xlabel('Length class');
            end

            if sp == 1
                lg = legend([hBar hBs hN hG hL], ...
                    {'Observed','B-spline','Normal','Gamma','Log-Normal'}, ...
                    'Location','northwest','Box','off');
                set(lg,'Color','none');
            end
        end
    end
end
