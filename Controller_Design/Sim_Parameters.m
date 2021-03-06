

%.. Global Variables

    global  UNIT_RAD2DEG    UNIT_DEG2RAD    UNIT_GRAV       UNIT_HP2W   
    global  Init_Pos        Init_Vel        Init_Euler      Init_Rate
    global  ALT             SOS_Table
    
%.. Load Trim Solution Found 

    load Trim_1.mat ;

%.. Unit Conversion 

    UNIT_RAD2DEG        =       180 / pi ;                              	% Radian to Degree
    UNIT_DEG2RAD        =       1 / UNIT_RAD2DEG ;                       	% Degree to Radian
    UNIT_HP2W           =       745.7 ;                                 	% Horse Power to Watt
    UNIT_GRAV           =       9.81 ;                                      % Gravity
    
%.. Setting up Simulation Parameters

    Step_Size           =       0.001 ;                                     % Step_Size for Numerical Integration
    
%.. Initial Conditions (you can change these values as you want)

    Init_Pos            =       [ 0.0, 0.0, 0.0 ] ;                         % Xe, Ye, Ze            (m)
    Init_Vel            =        x_trim(1:3); 
    Init_Euler          =        x_trim(7:9); 
    Init_Rate           =        x_trim(4:6); 
 
%.. Speed of Sound with Altitude Lookup Table)
    ALT = [0.0 1000 2000 3000 4000]
    SOS_Table = [340.268 336.408 332.504  328.553 324.554] 
