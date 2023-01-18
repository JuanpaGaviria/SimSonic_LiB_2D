%% Defining Geometry.map2D file
grid_step_mm = 0.0025;
Geometry_condition = 0;
if Geometry_condition == 1
    layers = 144;
    indexes = [7,6,7,2,5,2,7,6,7,3,4,3];  %Geometric unit
    esp_2 = 0.066;  % anode
    esp_3 = 0.059;  % cathode
    esp_4 = 0.01;  % positive
    esp_5 = 0.01;  % negative
    esp_6 = 0.025;  % separator
    esp_7 = 0.015;  % electrolite
    espesor_list = [esp_7,esp_6,esp_7,esp_2,esp_5,esp_2,esp_7,esp_6,esp_7,esp_3,esp_4,esp_3];
    OD = 18.5;
    ND = 18;
    external_dim_1 = 20;
    external_dim_2 = 20;
    % External domain creation
    N1 = external_dim_1 / grid_step_mm+1;
    N2 = external_dim_2 / grid_step_mm+1;
    TotalGeometry_old = uint8(zeros(N1,N2));
    TotalGeometry_old = Geometry(OD, ND, grid_step_mm, 1, TotalGeometry_old);
    indexes_counter = 1;
    %Internal domain creation
    for i= 1:layers/2+1
        OD = ND;
        ND = OD - espesor_list(indexes_counter);
        TotalGeometry_old = Geometry(OD, ND, grid_step_mm, indexes(indexes_counter), TotalGeometry_old);
        indexes_counter = indexes_counter + 1;
        if indexes_counter > numel(indexes)
            indexes_counter = 1;
        end
    end

    figure()
    imagesc(TotalGeometry_old);axis image
    SimSonic2DWriteMap2D(TotalGeometry_old)
end

%% Defining Parameters.ini2D genearal parameters
parameters_condition = 1;
if parameters_condition == 1
    parameters = GeneralParametersSimSonic;
    parameters.Grid_step_mm = grid_step_mm; % mm
    parameters.Vmax = 7.3; % mm/us
    parameters.SimulationLen = 10; %  Microseconds
    parameters.SnapRecordPeriod = 1; % microseconds
    % Type of source terms
    % 1: source term in the equations (default)
    % 2: forced values
    parameters.TypeSourceTerms = 2;
    %% Defining Parameters.ini2D Emitters

    % Defining emitters
    emitter1 = EmitterSimSonic('T11');
    emitter1.NormalOrientation = 2;
    emitter1.Origin = [4001,299];
    emitter1.ConditionsArray = [1 20 12 0 0];

    %emitter2 = EmitterSimSonic('T22');
    emitters = [emitter1];
    %emitters = [emitter1 emitter2];


    %% Defining Parameters.ini2D Receivers
    %for ConditionsArray:
    % NBElts (Number N of (identical) elements in the array)
    % Pitch (center to center distance between two consecutive elements)
    % Width (dimension of each elements. each element is integrating over its width)
    receiver1 = ReceiverSimSonic('T11','R001');
    receiver1.NormalOrientation = 1;
    receiver1.Origin = [4001 299];
    receiber1.ConditionsArray = [1 1 1];

    receiver2 = ReceiverSimSonic('T11','R002');
    receiver2.NormalOrientation = 1;
    receiver2.Origin = [4001 7702];
    receiber2.ConditionsArray = [1 1 1];
    
    receiver3 = ReceiverSimSonic('T11', 'R003');
    receiver3.NormalOrientation = 1;
    receiver3.Origin = [4001 858];
    receiber3.ConditionsArray = [1 1 1];
    
    receiver4 = ReceiverSimSonic('T11', 'R004');
    receiver4.NormalOrientation = 1;
    receiver4.Origin = [4001 3702];
    receiber4.ConditionsArray = [1 1 1];
    
    receivers = [receiver1 receiver2 receiver3 receiver4];


    %% Defining Materials properties

    %MaterialsSimSonic(type,index,density,cValues)
    materialWater = MaterialsSimSonic('water',0,1.0,[2.25 2.25 2.25 0.0]);
    materialStainSteel = MaterialsSimSonic('stainlessSteel', 1, 7.93, [515 515 515 515]);
    materialAnode = MaterialsSimSonic('anode', 2, 2.05, [1105 1105 204 450]);
    materialCathode = MaterialsSimSonic('cathode', 3, 5.01,[422 422 106 68.1]);
    materialPositiveC = MaterialsSimSonic('positive', 4, 8.96,[75.8 113.9 -10.5 10.5]);
    materialNegativeC = MaterialsSimSonic('negative', 5, 2.7,[69 69 69 69]);
    materialSeparator = MaterialsSimSonic('separator', 6, 0.55 ,[0.7 0.7 0.7 0.7]);
    materialElectrolite = MaterialsSimSonic('electrolite', 7, 1594 ,[1.32 1.32 1.32 1.32]);
    materials = [materialWater materialStainSteel materialAnode materialCathode materialPositiveC materialNegativeC];

    %% Parameters.ini2D
    SimSonic2DwriteParametersini2D(parameters,emitters,receivers,materials)
end

%% Defining Signal.sgl file



