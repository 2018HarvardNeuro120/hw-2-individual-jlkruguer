% 3. Image demixing: visual cocktail party problem.

%% Part (a): Covariance matrix and PCA
tic
load('toWhiten.mat')

% Part (i): Inline function that 
% I kept getting as
subtract_mean = inline('dat_matrix - mean_cols(row_vec,:)','dat_matrix','mean_cols','row_vec'); 
% ^^^ This function should work, however I keept getting an error from the inline function that the matrices 
% are not of the same dimenstion which is not the case, so I simply
% implemented the same logic below that was meant to be executed in the
% inline function.

row_vec = ones(1,(size(toWhiten,1)));
mean_cols = (row_vec*toWhiten)/size(toWhiten,1);
mean_of_dat = mean_cols(row_vec,:);
%dat_mean_subtracted = subtract_mean('toWhiten', 'mean_cols','row_vec');
dat_mean_subtracted = toWhiten - mean_of_dat;

% Part (ii): covariance function
covA = covariance_matrix(dat_mean_subtracted, toWhiten);

% Part (iii): eig
[eigen_vectors, eigen_values] = eig(covA);
feature_subspace = toWhiten*eigen_vectors;
toc
%% Scatter Plots
scatter(toWhiten(:,1), toWhiten(:,2)) % toWhiten.mat
hold on;
scatter(feature_subspace(:,1), feature_subspace(:,2), 'MarkerFaceColor', 'red')
%%
% Part (iv)
a = rand(1000, 5000);
b = rand(5000, 1000);
%% svd runtime
tic
a = svd(a);
toc
tic
b = svd(b);
toc
%% calculation and diagonalization of covariance matrix runtime
tic
row_vec = ones(1,(size(a,1)));
mean_cols = (row_vec*a)/size(a,1);
mean_of_dat = mean_cols(row_vec,:);
dat_mean_subtracted = a - mean_of_dat;

covA = covariance_matrix(dat_mean_subtracted, a);

[eigen_vectors, eigen_values] = eig(covA);
feature_subspace = a*eigen_vectors;
toc
tic
row_vec = ones(1,(size(b,1)));
mean_cols = (row_vec*b)/size(b,1);
mean_of_dat = mean_cols(row_vec,:);
dat_mean_subtracted = b - mean_of_dat;

covA = covariance_matrix(dat_mean_subtracted, b);

[eigen_vectors, eigen_values] = eig(covA);
feature_subspace = b*eigen_vectors;
toc

