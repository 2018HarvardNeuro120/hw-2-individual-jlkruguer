function [covA] = covariance_matrix(data_mean_subtracted, orig_dat)
% Calculate covariance matrix of the original data
covA = (data_mean_subtracted.'*data_mean_subtracted)/(size(orig_dat,1)-1);
end

