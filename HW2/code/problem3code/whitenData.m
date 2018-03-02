function whitened_data = whitenData(data)

% 1) Remove the mean of the data:
avg = mean(data, 1);
mean_subtracted = data - repmat(avg, size(data,1), 1);

% 2) Project data into the basis of principle components

covA = covariance_matrix(mean_subtracted, data);


[eigen_vectors, eigen_values] = eig(covA);


% 3) Scale pc with corresponding eigenvalue
whitened_data = diag(1./sqrt(diag(eigen_values) + epsilon)) * eigen_vectors' * mean_subtracted;

end
