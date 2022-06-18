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

%% Linearization for longitunidal motion

[A, B, C, D]    =  linmod('Linearize_Missile_Model',X0',U0')


%% Longitudinal Dynamics
A_long          =       zeros( 4, 4 ) ;
B_long          =       zeros( 4, 2 ) ;
C_long          =       zeros( 4, 4 ) ;
D_long          =       zeros( 4, 2 ) ;

Idx_U = 10;
Idx_W = 12 ;
Idx_Q = 5;
Idx_THETA  = 8;


A_long(1,:)     =       [ A(    Idx_U,Idx_U), A(    Idx_U,Idx_W), A(    Idx_U,Idx_Q), A(    Idx_U,Idx_THETA) ] ;
A_long(2,:)     =       [ A(    Idx_W,Idx_U), A(    Idx_W,Idx_W), A(    Idx_W,Idx_Q), A(    Idx_W,Idx_THETA) ] ;
A_long(3,:)     =       [ A(    Idx_Q,Idx_U), A(    Idx_Q,Idx_W), A(    Idx_Q,Idx_Q), A(    Idx_Q,Idx_THETA) ] ;
A_long(4,:)     =       [ A(Idx_THETA,Idx_U), A(Idx_THETA,Idx_W), A(Idx_THETA,Idx_Q), A(Idx_THETA,Idx_THETA) ] ;

B_long(:,1)     =       [ B(Idx_U,1), B(Idx_W,1), B(Idx_Q,1), B(Idx_THETA,1) ]' ;
B_long(:,2)     =       [ B(Idx_U,3), B(Idx_W,3), B(Idx_Q,3), B(Idx_THETA,3) ]' ;

C_long(1,:)     =       [ C(    Idx_U,Idx_U), C(    Idx_U,Idx_W), C(    Idx_U,Idx_Q), C(    Idx_U,Idx_THETA) ] ;
C_long(2,:)     =       [ C(    Idx_W,Idx_U), C(    Idx_W,Idx_W), C(    Idx_W,Idx_Q), C(    Idx_W,Idx_THETA) ] ;
C_long(3,:)     =       [ C(    Idx_Q,Idx_U), C(    Idx_Q,Idx_W), C(    Idx_Q,Idx_Q), C(    Idx_Q,Idx_THETA) ] ;
C_long(4,:)     =       [ C(Idx_THETA,Idx_U), C(Idx_THETA,Idx_W), C(Idx_THETA,Idx_Q), C(Idx_THETA,Idx_THETA) ] ;

D_long(:,1)     =       [ D(Idx_U,1), D(Idx_W,1), D(Idx_Q,1), D(Idx_THETA,1) ]' ;
D_long(:,2)     =       [ D(Idx_U,2), D(Idx_W,2), D(Idx_Q,2), D(Idx_THETA,2) ]' ;

A_long
B_long
C_long
D_long
   
%% Save the Longitudinal Model
save( 'Longitudinal_linear_Model.mat', 'A_long', 'B_long', 'C_long', 'D_long') ;
    