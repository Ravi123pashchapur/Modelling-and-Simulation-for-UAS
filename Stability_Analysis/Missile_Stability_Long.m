%% Load longitudinal linear model 
load Longitudinal_linear_Model.mat;

%% Finding Eigenvalues
Eig_Long = eig(A_long)

%% Transfer function representation
long_sys = ss(A_long, B_long, C_long, D_long)
figure
pzmap(long_sys)
title('Longitudinal Mode')
xlabel('Real Axis') 
ylabel('Imaginary Axis')
grid on
