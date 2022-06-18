clc
clear all
clear

%% Load Missile Data and Sim Parameters
Missile_Data;
Sim_Parameters ;
%% Initial Values of Additional Constraints for Trim
Init_Cnstr1 = 0;                                       % Speed Constraint1 
Init_Cnstr2 = 0;                                       % Pull-up for Constraint2 
Init_Cnstr3 = 0;                                       % Turn for Constraint3 
    
%% Initilsation of Trim Conditions for Altitude,Mach and speed

Alt_Trim = 0;
Mach_Trim = 0;
Speed_Trim = 0;

%% Pull-up Constraint for Trim condition

Theta_dot_Trim = 0 * UNIT_DEG2RAD;                
    
%% Coordinate Turn Constraint for Trim condition

Turn_dot_Trim = 0 * UNIT_DEG2RAD;            
G_Turn = Turn_dot_Trim * Speed_Trim / UNIT_GRAV;

%% Rate of Climb Constraint for Trim condition

Gamma_Trim = 0 * UNIT_DEG2RAD;
%% Identify names and states from Simulink model

[ sizes, x0, names] = Missile_Model_Trim
names{:}

disp('Missile Flight Trim Condition')
disp('Mach_Trim = 0.7')
disp('Altitude_Trimm = 0 m')


%% Initial  given variable 
Alt_Trim            =        0.0;                                      
Mach_Trim          =         0.7;                                       
Speed_Trim          =       Mach_Trim*interp1(ALT,SOS_Table,Alt_Trim);  

%% Identify the states and Inputs

X0(1)           =   Speed_Trim;
X0(2)           =   0.0;
X0(3)           =   0.0 ;
X0(4)           =   0.0 * UNIT_DEG2RAD;
X0(5)           =   0.0 * UNIT_DEG2RAD;
X0(6)           =   0.0 * UNIT_DEG2RAD;
X0(7)           =   0.0 * UNIT_DEG2RAD;
X0(8)           =   0.0 * UNIT_DEG2RAD;
X0(9)           =   0.0 * UNIT_DEG2RAD;
X0(10)          =   0.0;
X0(11)          =   0.0;
X0(12)          =   0.0;

U0(1)           =   0.0;
U0(2)           =   0.0 * UNIT_DEG2RAD;
U0(3)           =   0.0 * UNIT_DEG2RAD;
U0(4)           =   0.0 * UNIT_DEG2RAD;


%% Finding Trim data
[ x_trim, u_trim, y_trim, xd_trim ] = trim('Missile_Model_Trim',X0',U0')




%% Display the Result
disp('Mach = 0.7 and h =0 m')
disp('_______________________________________________')
disp('                  Trim States                  ')
disp('_______________________________________________')

fprintf(' u      = %f m/s\n', x_trim(1));
fprintf(' v      = %f m/s\n', x_trim(2));
fprintf(' w      = %f m/s\n', x_trim(3));
fprintf(' p      = %f deg/s\n', x_trim(4)*UNIT_RAD2DEG);
fprintf(' q      = %f deg/s\n',x_trim(5)*UNIT_RAD2DEG);
fprintf(' r      = %f deg/s\n',x_trim(6)*UNIT_RAD2DEG);
fprintf(' Phi    = %f deg/s\n', x_trim(7)*UNIT_RAD2DEG);
fprintf(' Theta  = %f deg/s\n',x_trim(8)*UNIT_RAD2DEG);
fprintf(' Psi    = %f deg/s\n', x_trim(9)*UNIT_RAD2DEG);
fprintf(' Alpha  = %f deg\n', y_trim(10)*UNIT_RAD2DEG);
fprintf(' Beta   = %f deg\n', y_trim(11)*UNIT_RAD2DEG);
fprintf(' VT     = %f m/s\n', y_trim(12)) ;

disp('_______________________________________________')
disp('                Trim Control Input             ')
disp('_______________________________________________')

fprintf(' del_T  = %f N\n',u_trim(1));
fprintf(' del_r  = %f deg\n',u_trim(2)*UNIT_RAD2DEG);
fprintf(' del_p  = %f deg\n',u_trim(3)*UNIT_RAD2DEG);
fprintf(' del_y  = %f deg\n',u_trim(4)*UNIT_RAD2DEG);
%% Saving trim data
save( 'Trim_1.mat', 'x_trim', 'u_trim', 'y_trim', 'xd_trim', 'Mach_Trim', 'Alt_Trim','Theta_dot_Trim','Gamma_Trim','Turn_dot_Trim' ) ;