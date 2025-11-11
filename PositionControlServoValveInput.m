%  ORIGINAL PARAMETERS  
% Valve body
dampCoeff         = 1e-1;                  % (N-s/m) Damping coefficient
springCoeff       = 1e4;                   % (N/m) Spring coefficient
spoolUB           = 1;                     % (mm) Spool movement upper bound
spoolLB           = -1;                    % (m) Spool movement lower bound
hardstopK         = 1e10;                  % (N/m) Hard stop stiffness coefficient
hardstopC         = 0.1;                   % (N-s/m) Hard stop damping coefficient
spoolMass         = 0.1;                   % (kg) Spool mass
breakawayF        = 1;                     % (N) Spool breakaway friction
breakfricV        = 0.01;                  % (m/s) Spool breakaway friction velocity
coloumbF          = 0.8;                   % (N) Spool coloumb friction
spoolArea         = 200;                   % (mm^2) Spool diameter
deadVol           = 1e-5;                  % (m^3) Dead volume in chamber
orificeWidth      = 0.03;                  % (mm) Spool orifice width
spoolTravel       = 1;                     % (mm) Spool travel between closed and open orifice
overlap           = 0.1;                   % (mm) Spool position at closed orifice
radClearance      = 0.05;                  % (mm) Spool radial clearance
pInitRightChamber  = 21e6;                  % (MPa) Initial pressure right chamber
pInitLeftChamber   = 21e6;                  % (MPa) Initial pressure left chamber

% Flapper nozzle circuit
fixedOrificeArea  = 2;                     % (mm^2) Fixed orifice area
filterArea        = 100;                   % (mm^2) Filter area
flapperRotAngle   = 3.4928;                % (deg) Maximum flapper rotation angle
flapperLength     = 5e-3;                  % (m) Flapper length
nozArea           = 3;                     % (mm^2) Nozzle max area
closePosition     = 3e-4;                  % (m) Flapper position for closed nozzle
flapperTravel     = 6e-4;                  % (m) Flapper travel
flexureStiffness  = 1e3;                   % (N/m) Flexure stiffness
nozCrossSectArea  = (pi/4)*(1.6e-3^2);     % (m^2) Nozzle cross section area

% Torque motor
motorInertia      = 10;                    % (g-mm^2) Motor inertia
motorC            = 1;                     % (V/(rad/s)) Constant of proportionality
motorR            = 750;                   % (ohm) Motor resistance
motorI            = 10;                    % (mH) Motor inductance
motorDampCoeff    = 1e-3;                  % (N-s/m) Damping coefficient
torsionStiffness  = 3;                     % (N*m/rad) Motor torsion spring stiffness


% APPLYING THE PARAMETERS TO SIMULINK BLOCKS 


set_param('PositionControlServoValve/Position Control Servo Valve/Reservoir',...
          'p_tank', '0.1e6');
ssc_domain('PositionControlServoValve','isothermal_liquid',...
           'MinimumValidPressure', 0.5e6);
set_param('PositionControlServoValve/Actuator/Actuator Cylinder',...
          'p_A_initial', '21e6', 'p_B_initial', '21e6');
set_param('PositionControlServoValve/Position Control Servo Valve/Valve Body/Spool Side A',...
          'p_initial', '21e6');
set_param('PositionControlServoValve/Position Control Servo Valve/Valve Body/Spool Side B',...
          'p_initial', '21e6');


%  SOLVER SETTINGS 

set_param('PositionControlServoValve/Solver Configuration',...
          'SolverType', 'BackwardEuler',...
          'RelTol', '1e-6',...
          'AbsTol', '1e-8',...
          'MaxStep', '1e-4',...
          'MinStep', '1e-9');

%  5.  SDRE CONTROLLER GAIN 

K_SDRE = [2.0954e3  44.721  3.863e-3];
assignin('base','K_SDRE',K_SDRE);
