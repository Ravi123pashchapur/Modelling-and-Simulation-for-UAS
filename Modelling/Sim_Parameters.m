
%.. Global Variables

    global  UNIT_RAD2DEG    UNIT_DEG2RAD    UNIT_GRAV          
    global  Init_Pos        Init_Vel        Init_Euler      Init_Rate

%.. Unit Conversion 

    UNIT_RAD2DEG        =       180 / pi ;                              	% Radian to Degree
    UNIT_DEG2RAD        =       1 / UNIT_RAD2DEG ;                       	% Degree to Radian
    UNIT_GRAV           =       9.81 ;                                      % Gravity
    
%.. Setting up Simulation Parameters

    Step_Size           =       0.001 ;                                     % Step_Size for Numerical Integration
    
%.. Initial Conditions (you can change these values as you want)

    Init_Pos            =       [ 0.0, 0.0, 0.0 ] ;                         % Xe, Ye, Ze            (m)
    Init_Vel            =       [ 238.0, 0.0, 0.0 ] ; 
    Init_Euler          =       [ 0.0, 0.0, 0.0 ] * UNIT_DEG2RAD ; 
    Init_Rate           =       [ 0.0, 0.0, 0.0 ] * UNIT_DEG2RAD ; 
    
