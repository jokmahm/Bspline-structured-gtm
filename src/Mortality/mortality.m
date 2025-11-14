function M = mortality(m1, m2, m3)
    global model
    x_mid = model.x_mid;

    % Initialize result vector with the same length as x_mid
    M = zeros(size(x_mid));

    l1 = 9;
    l2 = 17; 

    % Apply conditions to determine values based on x_mid
    M(x_mid < l1) = m1;
    M((x_mid >= l1) & (x_mid < l2)) = m2;
    M(x_mid >= l2) = m3;

    M = M';
end

