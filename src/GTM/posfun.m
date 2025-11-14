function result = posfun(x, eps)
    if x >= eps
        result = x;
    else
        y = 1.0 - x / eps;
        result = 0.5 * eps * (1 + exp(-y));
    end
end
