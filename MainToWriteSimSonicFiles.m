%%
% Figure seetings

graph = GraphSettings;
axisSize = graph.AxisSize;
axisWidth = graph.AxisWidth;
interpreter = graph.Interpreter;
lineWidth = graph.LineWidth;
fontSize = graph.FontSize;
%% Defining Geometry.map2D file

%
grid_step_mm = 0.0025; % Each pixel represents this mm
Geometry_condition = true;
if Geometry_condition
    indexes = [3,4,3,6,2,5,2,6];  %Geometric unit without electrolyte and separator
    esp_2 = 0.066*2;  % anode (Graphite)
    esp_3 = 0.058*2;  % cathode (NMC)
    esp_4 = 0.02*2;  % positive (Aluminium)
    esp_5 = 0.01*2;  % negative (Copper)
    esp_6 = 0.029*2;  % separator
    esp_7 = 0.3;  % electrolyte
    % te
    espesor_list = [esp_3,esp_4, esp_3, esp_6, esp_2,esp_5,esp_2, esp_6];
    esp_geometric_unit = sum(espesor_list,'all');
    ID = 0.3;
    OD = 18.4;
    ND = 17.4;
    layers = round((ND-ID)/(esp_geometric_unit))*numel(indexes)*2;
    external_dim_1 = 20;
    external_dim_2 = 20;
    % External domain creation
    N1 = external_dim_1 / grid_step_mm+1;
    N2 = external_dim_2 / grid_step_mm+1;
    TotalGeometry_old = uint8(zeros(N1,N2));
    TotalGeometry_old = Geometry(OD, ND, grid_step_mm, 1, TotalGeometry_old);
    indexes_counter = 1;
    %Internal domain creation
    for i= 1:layers/2
        OD = ND;
        ND = OD - espesor_list(indexes_counter);
        TotalGeometry_old = Geometry(OD, ND, grid_step_mm, indexes(indexes_counter), TotalGeometry_old);
        indexes_counter = indexes_counter + 1;
        if indexes_counter > numel(indexes)
            indexes_counter = 1;
        end
    end
    ID = ND;
    TotalGeometry_old = Geometry_Final(ID, grid_step_mm, 5, TotalGeometry_old);
    
    fig = figure();fig.Position = [349 223 790 643];
    imagesc(0:grid_step_mm:external_dim_1,0:grid_step_mm:external_dim_2,TotalGeometry_old);axis image
    ax2=gca;
    set(ax2,'FontSize',axisSize+5,'LineWidth',axisWidth,'TickLabelInterpreter',interpreter,'Box','on')
    xlabel('Distance [mm]','FontSize',axisSize+5,'Interpreter', interpreter)
    ylabel('Distance [mm]','FontSize',axisSize+5,'Interpreter', interpreter)
    SimSonic2DWriteMap2D(TotalGeometry_old)
end

%% Defining Parameters.ini2D general parameters
parameters_condition = true;
if parameters_condition
    parameters = GeneralParametersSimSonic;
    parameters.Grid_step_mm = grid_step_mm; % mm
    parameters.Vmax = (1105/2.05)^(1/2);
    parameters.SimulationLen = 22; %  Microseconds
    parameters.SnapRecordPeriod = 0.2; % microseconds
    parameters.RecordVAR = [0 0 0 0 1]; % Snapshots desired
    % Type of source terms
    % 1: source term in the equations (default)
    % 2: forced values
    parameters.TypeSourceTerms = 2;
    %% Defining Parameters.ini2D Emitters

    % Defining emitters
    emitter1 = EmitterSimSonic('T11');
    emitter1.NormalOrientation = 2; %1
    emitter1.Origin = [4001,320];
    %emitter1.Origin = [4001,320];
    %emitter1.ConditionsArray = [1 20 10/grid_step_mm 0 0];
    emitter1.ConditionsArray = [1 20 12 0 0];

    emitter2 = EmitterSimSonic('T22');
    emitter2.NormalOrientation = 2; %1
    emitter2.Origin = [4001,320];
    %emitter2.Origin = [4001,320];
    %emitter2.ConditionsArray = [1 20 10/grid_step_mm 0 0];
    emitter2.ConditionsArray = [1 20 12 0 0];

    %emitter2 = EmitterSimSonic('T22');
    %emitters = [emitter1];
    emitters = [emitter1 emitter2];


    %% Defining Parameters.ini2D Receivers
    %for ConditionsArray:
    % NBElts (Number N of (identical) elements in the array)
    % Pitch (center to center distance between two consecutive elements)
    % Width (dimension of each elements. each element is integrating over its width)
    
    
    receiver1 = ReceiverSimSonic('T11','R001');
    receiver1.NormalOrientation = 1;
    receiver1.Origin = [4001 319];
    receiver1.ConditionsArray = [1 1 1];

    receiver2 = ReceiverSimSonic('T11','R002');
    receiver2.NormalOrientation = 1;
    receiver2.Origin = [4001 320];
    receiver2.ConditionsArray = [1 1 1];

    receiver3 = ReceiverSimSonic('T11','R003');
    receiver3.NormalOrientation = 1;
    receiver3.Origin = [4001 321];
    receiver3.ConditionsArray = [1 1 1];

    receiver4 = ReceiverSimSonic('T11','R004');
    receiver4.NormalOrientation = 1;
    receiver4.Origin = [4001 519];
    receiver4.ConditionsArray = [1 1 1];

    receiver5 = ReceiverSimSonic('T11','R005');
    receiver5.NormalOrientation = 1;
    receiver5.Origin = [4001 520];
    receiver5.ConditionsArray = [1 1 1];

    receiver6 = ReceiverSimSonic('T11','R006');
    receiver6.NormalOrientation = 1;
    receiver6.Origin = [4001 521];
    receiver6.ConditionsArray = [1 1 1];
    
    receiver7 = ReceiverSimSonic('T11','R007');
    receiver7.NormalOrientation = 1;
    receiver7.Origin = [4001 7841];
    receiver7.ConditionsArray = [1 1 1];

    receiver8 = ReceiverSimSonic('T11','R008');
    receiver8.NormalOrientation = 1;
    receiver8.Origin = [4001 7842];
    receiver8.ConditionsArray = [1 1 1];

    receiver9 = ReceiverSimSonic('T11','R009');
    receiver9.NormalOrientation = 1;
    receiver9.Origin = [4001 7843];
    receiver9.ConditionsArray = [1 1 1];

    receiver10 = ReceiverSimSonic('T11','R010');
    receiver10.NormalOrientation = 1;
    receiver10.Origin = [4001 7681];
    receiver10.ConditionsArray = [1 1 1];

    receiver11 = ReceiverSimSonic('T11','R011');
    receiver11.NormalOrientation = 1;
    receiver11.Origin = [4001 7682];
    receiver11.ConditionsArray = [1 1 1];

    receiver12 = ReceiverSimSonic('T11','R012');
    receiver12.NormalOrientation = 1;
    receiver12.Origin = [4001 7683];
    receiver12.ConditionsArray = [1 1 1];

    receiver13 = ReceiverSimSonic('T11','R013');
    receiver13.NormalOrientation = 1;
    receiver13.Origin = [319 4001];
    receiver13.ConditionsArray = [1 1 1];

    receiver14 = ReceiverSimSonic('T11','R014');
    receiver14.NormalOrientation = 1;
    receiver14.Origin = [320 4001];
    receiver14.ConditionsArray = [1 1 1];

    receiver15 = ReceiverSimSonic('T11','R015');
    receiver15.NormalOrientation = 1;
    receiver15.Origin = [7681 4001];
    receiver15.ConditionsArray = [1 1 1];

    receiver16 = ReceiverSimSonic('T11','R016');
    receiver16.NormalOrientation = 1;
    receiver16.Origin = [7682 4001];
    receiver16.ConditionsArray = [1 1 1];

  
    
    receivers = [receiver1 receiver2 receiver3 receiver4 ...
        receiver5 receiver6 receiver7 receiver8 ...
        receiver9 receiver10 receiver11 receiver12 ...
        receiver13 receiver14 receiver15 receiver16];


    %% Defining Materials properties

    % NMC lame parameters [GPa]
    lambdaNMC = 8.31; muNMC = 5.54; 
    % graphite lame parameters [GPa]
    lambdaGraphite = 3.19; muGraphite = 3.46;
    % Aluminium lame parameters [GPa]
    lambdaAluminium = 51.71; muAluminium = 25.93;
    % Copper lame parameters [GPa]
    lambdaCopper = 90.23; muCopper = 40.16;
    % Separator lame parameters [GPa]
    lambdaSeparator = 1.42; muSeparator = 0.12;

    % Index Density [C11 C22 C12 C66]

    materialOil = MaterialsSimSonic('water',0,0.83,[2.25 2.25 2.25 0.0]);  % Oil
    materialStainSteel = MaterialsSimSonic('stainlessSteel', 1, 7.88, [204.6 204.6 137.7 126.2]); % austenitic stainless steel
    materialAnode = MaterialsSimSonic('Graphite', 2, 1.06, [lambdaGraphite+2*muGraphite lambdaGraphite+2*muGraphite lambdaGraphite muGraphite]);   % Graphite
    materialCathode = MaterialsSimSonic('NMC', 3, 1.54,[lambdaNMC+2*muNMC lambdaNMC+2*muNMC lambdaNMC muNMC]);      %NMC cathode
    materialPositiveC = MaterialsSimSonic('Aluminium', 4, 2.7,[lambdaAluminium+2*muAluminium lambdaAluminium+2*muAluminium lambdaAluminium muAluminium]); % Aluminum
    materialNegativeC = MaterialsSimSonic('Copper', 5, 8.96,[lambdaCopper+2*muCopper lambdaCopper+2*muCopper lambdaCopper muCopper]); % Copper
    materialSeparator = MaterialsSimSonic('separator', 6, 1.68 ,[lambdaSeparator+2*muSeparator lambdaSeparator+2*muSeparator lambdaSeparator muSeparator]);
    %materialElectrolyte = MaterialsSimSonic('electrolyte', 7, 1594 ,[1.32 1.32 1.32 1.32]);
    materials = [materialOil materialStainSteel materialAnode materialCathode materialPositiveC materialNegativeC materialSeparator];

%     materialWater = MaterialsSimSonic('water',0,0.83,[2.25 2.25 2.25 0.0]);  % Water
%     materialStainSteel = MaterialsSimSonic('stainlessSteel', 1, 7.93, [203.6 203.6 120.2 60.7]); % austenitic stainless steel
%     materialAnode = MaterialsSimSonic('Graphite', 2, 2.05, [1105 1105 204 450]);   % Graphite
%     materialCathode = MaterialsSimSonic('NMC', 3, 5.01,[422 422 106 68.1]);      %NMC cathode
%     materialPositiveC = MaterialsSimSonic('Aluminium', 4, 2.7,[107.3 107.3 54.5 28.2]); % Aluminum
%     materialNegativeC = MaterialsSimSonic('Copper', 5, 8.96,[170.7 171 121.0 75.6]); % Copper
%     materialSeparator = MaterialsSimSonic('separator', 6, 0.55 ,[0.7 0.7 0.7 0.7]);
%     %materialElectrolyte = MaterialsSimSonic('electrolyte', 7, 1594 ,[1.32 1.32 1.32 1.32]);
%     materials = [materialWater materialStainSteel materialAnode materialCathode materialPositiveC materialNegativeC];

    %% Parameters.ini2D
    SimSonic2DwriteParametersini2D(parameters,emitters,receivers,materials)
end

%% Defining Signal.sgl file

% Reading JSON file with the signal from the experimental setup
signal_condition = true;

if signal_condition
    fileName = 'signal.json';   % filename in JSON extension
    fid = fopen(fileName);      % Opening the file
    raw = fread(fid,inf);       % Reading the contents
    str = char(raw');           % Transformation
    fclose(fid);                % Closing the file
    data = jsondecode(str);     % Using the jsondecode function to parse JSON from string


    temporal_step_us = parameters.CFLCoefficient * parameters.Grid_step_mm/(sqrt(2)*parameters.Vmax);
    display(temporal_step_us);
    data.time = data.time*1000000;  % Pasando a us
    [interpolated_amplitude, interpolated_time] = signal_interpolation(data.amplitude, data.time, temporal_step_us);
    
    figure(2)
    plot(interpolated_time,interpolated_amplitude,'.-')
    interpolated_amplitude = interpolated_amplitude.';
    SimSonic2DWriteSgl(interpolated_amplitude)
    
end