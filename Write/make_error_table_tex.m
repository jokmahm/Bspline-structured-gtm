function tex = make_error_table_tex(year_start, year_finish, Err_bs, Err_nA, Err_gam, Err_lgn, varargin)
% Build a LaTeX table:
%   Year | B-spline | Normal (Chen) | Gamma | Log-Normal
% Rows cover years (year_start+1):year_finish (e.g., 1989..2017).

    % ---- parse options ----
    p = inputParser;
    addParameter(p, 'filename', 'gtm_error_table.tex', @ischar);
    addParameter(p, 'decimals', 4, @(x) isnumeric(x) && isscalar(x) && x>=0);
    addParameter(p, 'caption', 'Per-year projection error (||N_y - G N_{y-1}||_2) for each GTM', @ischar);
    addParameter(p, 'label', 'tab:gtm-errors', @ischar);
    addParameter(p, 'booktabs', true, @islogical);
    parse(p, varargin{:});
    opt = p.Results;

    years = (year_start+1):year_finish;     % e.g. 1989..2017
    nY = numel(years);

    % ensure column vectors
    Err_bs  = Err_bs(:);
    Err_nA  = Err_nA(:);
    Err_gam = Err_gam(:);
    Err_lgn = Err_lgn(:);

    % trim or pad to nY
    Err_bs  = pad_to_len(Err_bs,  nY);
    Err_nA  = pad_to_len(Err_nA,  nY);
    Err_gam = pad_to_len(Err_gam, nY);
    Err_lgn = pad_to_len(Err_lgn, nY);

    dfmt = ['%.' num2str(opt.decimals) 'f'];

    if opt.booktabs
        top = '\toprule'; mid = '\midrule'; bottom = '\bottomrule';
    else
        top = '\hline'; mid = '\hline'; bottom = '\hline';
    end

    % build table body
    bodyLines = cell(nY,1);
    for k = 1:nY
        line = sprintf('%d & %s & %s & %s & %s \\\\',...
            years(k), ...
            fmtnum(Err_bs(k),  dfmt), ...
            fmtnum(Err_nA(k),  dfmt), ...
            fmtnum(Err_gam(k), dfmt), ...
            fmtnum(Err_lgn(k), dfmt));
        bodyLines{k} = line;
    end
    tableBody = strjoin(bodyLines, sprintf('\n'));

    % columns format (right-aligned)
    colfmt = 'r r r r r';

    % assemble LaTeX
    tex = sprintf([ ...
        '\\begin{table}[ht]\n' ...
        '\\centering\n' ...
        '\\caption{%s}\n' ...
        '\\label{%s}\n' ...
        '\\begin{tabular}{%s}\n' ...
        '%s\n' ...
        'Year & B-spline & Normal & Gamma & Log-Normal \\\\\n' ...
        '%s\n' ...
        '%s\n' ...
        '%s\n' ...
        '\\end{tabular}\n' ...
        '\\end{table}\n' ], ...
        opt.caption, opt.label, colfmt, top, mid, tableBody, bottom);

    % write file
    if ~isempty(opt.filename)
        fid = fopen(opt.filename, 'w');
        assert(fid>0, 'Could not open file for writing: %s', opt.filename);
        fwrite(fid, tex);
        fclose(fid);
        fprintf('LaTeX table written to %s\n', opt.filename);
    end
end

% --------- helpers ----------
function v = pad_to_len(v, n)
    if numel(v) >= n
        v = v(1:n);
    else
        v(end+1:n,1) = NaN;
    end
end

function s = fmtnum(x, dfmt)
    if isnan(x)
        s = 'NaN';
    else
        s = sprintf(dfmt, x);
    end
end
