function [m,covm]=wlsi_cvary_linn(x,y,w,n)
% PERFORMS WEIGHTED LEAST-SQUARES INVERSION TO FIND A POLY FIT TO X VS Y
%
% CASE:
% - PREDICTORS X ARE ASSUMED KNOWN
% - OBSERVATIONS Y ARE ESTIMATED WITH VARIANCES ASSUMED KNOWN
% - VARIANCES OF OBSERVATIONS Y ARE ASSUMED TO BE NORMAL
% - VARIANCES OF OBSERVATIONS Y ARE CONSTANT
% - OBSERVATIONS Y ARE ASSUMED TO HAVE NO COVARIANCE
% - Y IS ASSUMED TO BE A POLYNOMIAL FUNCTION OF X OF ORDER N
% - SOME OBSERVATIONS Y ARE NOT TRUSTED
%
% NOTES:
% - MODEL COVARIANCE ASSUMES UNITY DATA VARIANCE

% MAKE COLUMN VECTORS
x=x(:);
y=y(:);
w=w(:);

% NUMBER OF OBSERVATIONS
len=length(x);

% MAKE WEIGHTING MATRIX
W=sparse(1:len,1:len,w,len,len);

% KERNEL MATRIX (SOLVE FOR POLYNOMIAL ORDER N)
G=[x(:,ones(n,1)).^repmat(n:-1:1,len,1) ones(len,1)];

% WEIGHTED LEAST SQUARES INVERSION (SAVING GENERALIZED INVERSE)
Gg=inv(G.'*W*G)*G.'*W;
m=Gg*y;

% FIND MODEL COVARIANCE MATRIX
covm=Gg*Gg.';

end