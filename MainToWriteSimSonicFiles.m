%% Defining Geometry.map2D file
grid_step_mm = 0.0025;
Geometry_condition = true;
if Geometry_condition
    indexes = [3,5,3,2];  %Geometric unit without electrolyte
    esp_2 = 0.066;  % anode
    esp_3 = 0.059;  % cathode
    esp_4 = 0.01;  % positive
    esp_5 = 0.01;  % negative
    esp_6 = 0.025;  % separator
    esp_7 = 0.3;  % electrolyte
    % te
    espesor_list = [esp_3,esp_5, esp_3, esp_2];
    %espesor_list = repmat(esp_2,1,10);
    esp_geometric_unit = sum(espesor_list,'all');
    ID = 4;
    OD = 18.5;
    ND = 18;
    layers = round((ND-ID-1)/(esp_geometric_unit))*numel(indexes)*2;
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
        if i == 4
           break;
        end
        if indexes_counter > numel(indexes)
            indexes_counter = 1;
        end
        
    end
    ID = ND;
%     TotalGeometry_old = Geometry_Final(ID, grid_step_mm, 7, TotalGeometry_old);

    figure()
    imagesc(TotalGeometry_old);axis image
    SimSonic2DWriteMap2D(TotalGeometry_old)
end

%% Defining Parameters.ini2D genearal parameters
parameters_condition = true;
if parameters_condition
    parameters = GeneralParametersSimSonic;
    parameters.Grid_step_mm = grid_step_mm; % mm
    parameters.Vmax = (1105/2.05)^(1/2);
    parameters.SimulationLen = 0.25; %  Microseconds
    parameters.SnapRecordPeriod = 0.005; % microseconds
    % Type of source terms
    % 1: source term in the equations (default)
    % 2: forced values
    parameters.TypeSourceTerms = 2;
    %% Defining Parameters.ini2D Emitters

    % Defining emitters
    emitter1 = EmitterSimSonic('T11');
    emitter1.NormalOrientation = 1;
    emitter1.Origin = [4001,299];
    emitter1.ConditionsArray = [1 20 12 0 0];

    emitter2 = EmitterSimSonic('T22');
    emitter2.NormalOrientation = 1;
    emitter2.Origin = [4001,299];
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
    receiver1.Origin = [4001 299];
    receiver1.ConditionsArray = [1 1 1];

    receiver2 = ReceiverSimSonic('T11','R002');
    receiver2.NormalOrientation = 1;
    receiver2.Origin = [4001 7702];
    receiver2.ConditionsArray = [1 1 1];
    
    receiver3 = ReceiverSimSonic('T11', 'R003');
    receiver3.NormalOrientation = 1;
    receiver3.Origin = [4001 858];
    receiver3.ConditionsArray = [1 1 1];
    
    receiver4 = ReceiverSimSonic('T11', 'R004');
    receiver4.NormalOrientation = 1;
    receiver4.Origin = [4001 3702];
    receiver4.ConditionsArray = [1 1 1];
    
    receivers = [receiver1 receiver2 receiver3 receiver4];


    %% Defining Materials properties
% 
    % Index Density [C11 C22 C12 C66]
    
     materialWater = MaterialsSimSonic('water',0,1.0,[2.25 2.25 2.25 0.0]);  % Water
     materialStainSteel = MaterialsSimSonic('stainlessSteel', 1, 7.93, [203.6 203.6 120.2 60.7]); % austenitic stainless steel
    %materials = [materialWater, materialStainSteel];
         materialAnode = MaterialsSimSonic('anode', 2, 2.05, [1105 1105 204 450]);   % Graphite
    materialCathode = MaterialsSimSonic('cathode', 3, 5.01,[422 422 106 68.1]);      %LCO cathode
    materialPositiveC = MaterialsSimSonic('positive', 4, 2.7,[107.3 107.3 54.5 28.2]); % Aluminum
    materialNegativeC = MaterialsSimSonic('negative', 5, 8.96,[170.7 171 121.0 75.6]); % Copper
    materialSeparator = MaterialsSimSonic('separator', 6, 0.55 ,[0.7 0.7 0.7 0.7]);
    %materialElectrolite = MaterialsSimSonic('electrolyte', 7, 1594 ,[1.32 1.32 1.32 1.32]);
    materials = [materialWater materialStainSteel materialAnode materialCathode materialPositiveC materialNegativeC];

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