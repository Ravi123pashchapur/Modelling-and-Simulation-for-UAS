clc
clear all
clear

%% Load Missile data and Sim Parameters
Missile_Data;
Sim_Parameters ;
%% Load Trim data at h = 0 m and Mach = 0.7 
load Trim_1.mat ;
    
%% Estimation of Linear Model

[ sizes, x0, names] =  Linearize_Missile_Model;
names{:}

%% Initial state conditions for trim Values
X0(1)= 0.0;
X0(2)= 0.0;
X0(3)= -Alt_Trim ;
X0(4:6)= x_trim(4:6);
X0(7:9)= x_trim(7:9);
X0(10:12)= x_trim(1:3)
%% Initial inputs conditions for trim Values
U0=u_trim;

%% Linearization for lateral motion

[A, B, C, D]    =  linmod('Linearize_Missile_Model',X0',U0')

%% Lateral Dynamics

A_lat           =       zeros( 4, 4 ) ;
B_lat           =       zeros( 4, 2 ) ;
C_lat           =       zeros( 4, 4 ) ;
D_lat           =       zeros( 4, 2 ) ;

Idx_V = 11;
Idx_P = 4;
Idx_R = 6;
Idx_PHI = 7;

A_lat(1,:)      =       [ A(  Idx_V,Idx_V), A(  Idx_V,Idx_P), A(  Idx_V,Idx_R), A(  Idx_V,Idx_PHI) ] ;
A_lat(2,:)      =       [ A(  Idx_P,Idx_V), A(  Idx_P,Idx_P), A(  Idx_P,Idx_R), A(  Idx_P,Idx_PHI) ] ;
A_lat(3,:)      =       [ A(  Idx_R,Idx_V), A(  Idx_R,Idx_P), A(  Idx_R,Idx_R), A(  Idx_R,Idx_PHI) ] ;
A_lat(4,:)      =       [ A(Idx_PHI,Idx_V), A(Idx_PHI,Idx_P), A(Idx_PHI,Idx_R), A(Idx_PHI,Idx_PHI) ] ;

B_lat(:,1)      =       [ B(Idx_V,3), B( Idx_P,3), B(Idx_R,3), B(Idx_PHI,3) ]' ;
B_lat(:,2)      =       [ B(Idx_V,4), B( Idx_P,4), B(Idx_R,4), B(Idx_PHI,4) ]' ;

C_lat(1,:)      =       [ C(  Idx_V,Idx_V), C(  Idx_V,Idx_P), C(  Idx_V,Idx_R), C(  Idx_V,Idx_PHI) ] ;
C_lat(2,:)      =       [ C(  Idx_P,Idx_V), C(  Idx_P,Idx_P), C(  Idx_P,Idx_R), C(  Idx_P,Idx_PHI) ] ;
C_lat(3,:)      =       [ C(  Idx_R,Idx_V), C(  Idx_R,Idx_P), C(  Idx_R,Idx_R), C(  Idx_R,Idx_PHI) ] ;
C_lat(4,:)      =       [ C(Idx_PHI,Idx_V), C(Idx_PHI,Idx_P), C(Idx_PHI,Idx_R), C(Idx_PHI,Idx_PHI) ] ;

D_lat(:,1)      =       [ D(Idx_V,3), D( Idx_P,3), D(Idx_R,3), D(Idx_PHI,3) ]' ;
D_lat(:,2)      =       [ D(Idx_V,4), D( Idx_P,4), D(Idx_R,4), D(Idx_PHI,4) ]' ;

A_lat
B_lat
C_lat
D_lat
%% Save the Lateral Model
save( 'Lateral_linear_Model.mat','A_lat', 'B_lat', 'C_lat', 'D_lat') ;
