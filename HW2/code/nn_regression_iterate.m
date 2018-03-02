clear all
results = ones(40,2); % Will hold average mse for each network size
mse = []; % Will hold mse values for the 500 iterations on each network size  
for i=40:500
    for j=1:400
        
        
        %% Set up parameters
        N = 40; % Number of training samples
        epsilon = 0.2; % Amount of label noise
        Nh = 500;
        lambda = 1e-4;

        %% Make dataset
        target_fn = @(t) sin(t);
        x = linspace(-pi,pi,N);
        y = target_fn(x) + epsilon*randn(size(x));

        Ntest = 100;
        x_test = linspace(-pi,pi,Ntest);
        y_test = target_fn(x_test);

        Ni = 2;

        %% Compute network activity

        J = randn(Nh,Ni)/Nh;

        h = J*[x; ones(1,N)];
        h(h<0)=0;

        h_test = J*[x_test; ones(1,Ntest)];
        h_test(h_test<0)=0;


        %% Now train linear regression to map from h to y

        % w = ????
        w = (y*h')*pinv(h*h'+lambda); % Implemented linear regression with regularization

        y_pred = w*h_test;

        mean_squared_error = norm(y_test-y_pred).^2;
        
        mse(j) = mean_squared_error;

       
        disp(j)
    end 
    avg_mse = mean(mse);
    results(i,1) = i;
    results(i,2) = avg_mse;
    i = i+10
    disp(i)
end

%%
figure;
plot(results(:,1), results(:,2), 'o')
xlabel('Network size'); ylabel('Average Mean Squared Error');
