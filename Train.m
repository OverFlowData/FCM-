function W = FCM(ADCInd)

%n = size(concepts);
n = 42;
A = initial_activation(n);
W = initial_weight(n);
%conceptOrder = sort_concept(concepts);

M = 100;
b = 0.2;
lambda = 0.02;
e = 0.02;
newA = A;

J = zeros(1, M);
c = 1;
eta = 0.02 * exp(-0.2);
gamma = b * exp(-lambda);

criterion = 0;
while (~criterion)
    currentA = newA;
    if (c > M)
        c = 1;
        eta = 0.02 * exp(-0.2*c);
        gamma = b * exp(-lambda * c);
    end

    [newA newW] = AHL(W, currentA, eta, gamma);
    J(c) = sqrt(sum((newA(ADCInd)-min(newA)).^2+(newA(ADCInd)-max(newA)).^2));
    if (c > 2)
        if (~(J(c-2) > J(c-1) && J(c-1) > J(c)))
            c = c+1;
        else
            if (max(newA(ADCInd)-currentA(ADCInd)) > e)
                c = c+1;
            else
                criterion = 1;
            end
        end
    else
        c = c+1;
    end
    W = newW;
    save('result.txt', 'W');
end


