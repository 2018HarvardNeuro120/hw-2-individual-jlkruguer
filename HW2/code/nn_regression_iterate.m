clear all

%% Set up parameters
N = 40; % Number of training samples
epsilon = 0.2; % Amount of label noise
NhMulti = 500;
repMSE = 500; % Iterations used to average MSE for each network size
lambda = 0;
%lambda = 1e-4;

%% Make dataset
target_fn = @(t) sin(t);
x = linspace(-pi,pi,N);
y = target_fn(x) + epsilon*randn(size(x));

Ntest = 100;
x_test = linspace(-pi,pi,Ntest);
y_test = target_fn(x_test);

Ni = 2;

meanSquaredError = zeros(size(NhMulti)); % Will hold average mse for each network size
 
for i = 1 : length(NhMulti)
    Nh = NhMulti(i); % Network size by index
    disp(i)
    for j = 1 : repMSE 
        %% Compute network activity

        J = randn(Nh,Ni)/Nh;

        h = J*[x; ones(1,N)];
        h(h<0)=0;

        h_test = J*[x_test; ones(1,Ntest)];
        h_test(h_test<0)=0;


        %% Now train linear regression to map from h to y

        % w = ????
        w = (y*h')*pinv((h*h')+lambda*eye(size((h*h'),1))); % Implemented linear regression with regularization

        y_pred = w*h_test;

        mean_squared_error = norm(y_test-y_pred).^2;

        meanSquaredError(i) = meanSquaredError(i) + mean_squared_error;

      
    end
    close all
    plot(x,y,'ob')
    hold on
    plot(x_test,y_test)
    hold on
    plot(x_test,y_pred)

    text(-pi,[.1 .9]*get(gca,'YLim')',sprintf('MSE: %g ', mean_squared_error))
    xlabel('Input')
    ylabel('Output')
    legend('Training data','Test data','Prediction')
end

%%
figure;
plot(NhMulti, meanSquaredError/repMSE);
xlabel('Network size'); ylabel('Average Mean Squared Error');
