%% Load lateral linear model 
load Lateral_linear_Model.mat;

%% Finding Eigenvalues
Eig_Lat = eig(A_lat)

%% state space representation
lat_sys = tf(ss(A_lat, B_lat, C_lat, D_lat))
figure
pzmap(lat_sys)
title('Lateral Mode')
xlabel('Real Axis') 
ylabel('Imaginary Axis')
grid on

% comuting damping and natrual frequency
damp(lat_sys)