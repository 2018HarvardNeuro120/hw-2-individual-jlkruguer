%% 3. Image demixing: visual cocktail party problem.

clear all % Refresh Workspace
load('toWhiten.mat') % Toy data
load('mixedImg.mat') % Images

%% Part (a): Covariance matrix and PCA

% Part (i): 
subtractMean = @(dataMatrix) (dataMatrix - mean(dataMatrix)); % In line function: subtract mean from data matrix
dataMeanSubtracted = subtractMean(toWhiten); 

% Part (ii):
getCovariance = @(dataMeanSubtracted, originalData) (dataMeanSubtracted.'*dataMeanSubtracted)/(size(originalData,1)-1); % In line function: get covariance matrix
covarianceMatrix = getCovariance(dataMeanSubtracted, toWhiten);

if covarianceMatrix == cov(toWhiten) % Validate that my method works
    disp('getCovariance Works!')
end

% Part(iii): 
[eigenVectors, eigenValues] = eig(covarianceMatrix); % get eigenvalues and eigenvectors for covariance matrix
extractEigenValues = diag(eigenValues)'; % Eigenvalues 

% Coefficients of principle components
meanOfData = mean(toWhiten);
PC1 = eigenVectors(:,1).*extractEigenValues; 
PC2 = eigenVectors(:,2).*extractEigenValues;

% Coordinates to plot PCs
x = meanOfData(1)*ones(1,2);
y = meanOfData(2)*ones(1,2);
% Plots
scatter(toWhiten(:,1), toWhiten(:,2)); % Scatter plot of original data
hold on;
quiver(x,y,PC1,PC2) % Plot PCs

% Part(vi):
a = rand(1000,5000); % 1000x5000 test matrix
b = rand(5000,1000);% 5000x1000 test matrix

tic
svd(a); % SVD on matrix a
toc

tic
sm = subtractMean(a);
cov = getCovariance(sm,a); % Calculation + Diagonalization of Covariance Matrix
[V,D] = eig(cov);
toc

tic
svd(b); % SVD on matrix a
toc

tic
sm = subtractMean(b);
cov = getCovariance(sm,b); % Calculation + Diagonalization of Covariance Matrix
[V,D] = eig(cov);
toc

%% Part (b) Whitening the Data

whitenedData = whitenData(toWhiten); % Whiten the data using my function
scatter(whitenedData(:,1), whitenedData(:,2)); % Plot whitened data

%% Part (C)

% Part (i)
% See Figures & Plots/3. Image Demixing: visual cocktail party problem/Part c/Part i for all three images plotted using the plotImgs.m function

% Part (ii)
% whitenedImages = whitenData(imMix);
% plotImgs(whitenedImages);

% Part (iii)
% With Whitened images
weights = learnWeights(whitenedImages);
transform = whitenedImages*weights;
plotImgs(transform);

% Without whitened images (raw)
weights = learnWeights(imMix);
transform = imMix*weights;
plotImgs(transform);





