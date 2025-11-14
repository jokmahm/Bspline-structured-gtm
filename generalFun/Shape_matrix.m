function P = Shape_matrix(x)
    % Parameters
    L_inf = 21;
    K = 0.4;
    
    % Calculate mu vector
    mu = x + (L_inf - x) .* (1 - exp(-K));
    
    % Number of elements in x
    n = length(x);
    
    % Initialize P matrix
    P = zeros(n, n);
    
    % Create lower triangular matrix
    for j = 1:n
        % Calculate mean and standard deviation for normal distribution
        mu_j = mu(j);
        sigma = 0.7;
        
        % Evaluate normal distribution for each element in x
        P(:, j) = normpdf(x, mu_j, sigma);
        
        % Set elements above the diagonal to 0
        P(1:j-1, j) = 0;
        
        % Normalize the column
        if sum(P(:, j))~=0
            P(:, j) = P(:, j) / sum(P(:, j));
        end
    end
end
