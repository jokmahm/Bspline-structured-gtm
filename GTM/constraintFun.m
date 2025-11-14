function [c, ceq] = constraintFun(par)
    global model
    x_mid = model.x_mid;

    P = gtm_optimization(par(6:end));
    G = Shape_matrix(x_mid);

    % Find rows with all zeros in G
    zeroRows = all(P == 0, 2);

   % Calculate the constraint only for non-zero rows
    c = sum(sum(abs(P(~zeroRows, 1) - G(~zeroRows, 1))));
    
    % No equality constraint
    ceq = [];
end
