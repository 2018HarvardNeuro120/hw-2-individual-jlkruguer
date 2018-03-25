function whitened_data = whitenData(data)

% 1) Remove the mean of the data:
subtractMean = @(dataMatrix) (dataMatrix - mean(dataMatrix)); % In line function: subtract mean from data matrix
getCovariance = @(dataMeanSubtracted, originalData) (dataMeanSubtracted.'*dataMeanSubtracted)/(size(originalData,1)-1); % In line function: get covariance matrix

% 2) Project data into the basis of principle components
meanRemoved = subtractMean(data);
covarianceMatrix = getCovariance(meanRemoved, data);
[eigenVectors, eigenValues] = eig(covarianceMatrix);

% 3) Scale PCs with corresponding eigenvalue
scalarMultiplier = transpose(diag(eigenValues).^(0.5));
scaledEigenVectors = eigenVectors .* scalarMultiplier;
whitened_data = meanRemoved * scaledEigenVectors; 

end
