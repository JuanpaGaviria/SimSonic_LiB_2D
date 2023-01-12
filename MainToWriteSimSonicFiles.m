%% Add path SimSonic toolbox


%% Values used for simulation
% signal
f0 = 5.0; % MHz
duration = 4; %us
t0 = duration/2;
bw = 1;
CFL_coeff = 0.99;

% Media
Vmaximum = 7.3;               %mm/us
Vbackground = 1.5;              %mm/us
disk_diameter_mm = 18.5;
disk_diameter_mm_2 = 18;

% Dimensions grid for simulations
Dimension1_mm = 60;
Dimension2_mm = 60;

% simulation grid step
grid_step_mm = 0.0025;
% Simulation time
simulationTime = 50; % microseconds
recordPeriod = 1; % microseconds
% various derived parameters

lambda_scatterer = Vmaximum/f0;
lambda_background = Vbackground/f0;
Nb_pts_per_wavelength = lambda_background/grid_step_mm;
N1 = Dimension1_mm/grid_step_mm + 1;
N2 = Dimension2_mm/grid_step_mm + 1;
disk_diameter_pt = disk_diameter_mm/grid_step_mm+1;
disk_diameter_pt_2 = disk_diameter_mm_2/grid_step_mm+1;

%% Defining Parameters.ini2D file
% Defining general parameters

parameters = GeneralParametersSimSonic;
parameters.Grid_step_mm = grid_step_mm;
parameters.Vmax = Vmaximum;
parameters.SimulationLen = simulationTime;
parameters.SnapRecordPeriod = recordPeriod;

% Defining emitters
emitter1 = EmitterSimSonic('T11');
emitter1.ConditionsArray = [64	20	12	1	0];
emitter2 = EmitterSimSonic('T22');

emitters = [emitter1 emitter2];


% Defining receivers
receiver1 = ReceiverSimSonic('T11','R001');

receiver2 = ReceiverSimSonic('T11','R002');
receivers = [receiver1 receiver2];


% Defining Materials properties
materialWater = MaterialsSimSonic('water',1.0,[2.25 2.25 2.25 0.0]);
materialStainSteel = MaterialsSimSonic('stainlessSteel',8.03,[206.8   139.3	133.1	133.1]);
materials = [materialWater materialStainSteel];

% Parameters.ini2D construction

SimSonic2DwriteParametersini2D(parameters,emitters,receivers,materials)

%% Defining Geometry.map2D file



%% Defining Signal.sgl file

