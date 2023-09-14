classdef GeneralParametersSimSonic
    %UNTITLED11 Summary of this class goes here
    %   Detailed explanation goes here

    properties
        % General conditions of SimSonic simualtion
        Grid_step_mm    (1,1) double;   % Grid step in [mm];
        Vmax            (1,1) double;     % Aprox maximum velocity in the simulation [mm/us];
        SimulationLen   (1,1) double;    % Simulation duration [us]
        CFLCoefficient  (1,1) double = 0.99;   % For Cournat stability condition
        AbsorpType      (1,1) uint8 = 0;        % Defining if we want to include absorption model

        % Boundary conditions for [X1_low,X1_high,X2_low,X2_high] axis
        % 0 : PML, 1 : Symetrical, 2 : Free, 3 : Rigid
        Boundaries (1,4)  uint8 = [0 0 0 0];
        

        % PML characteristics (Perfecty-Matched Layers)
        PMLThickness    (1,1) double = 30;    % (grid step)
        VmaxPML         (1,1) double = 1.5;   % [mm/us]
        PMLEfficiency   (1,1) double = 120.0; % [dB]
         


        % Record variables
        SnapRecordPeriod (1,1) double; % [us]
        RecordVAR        (1,6) uint8 = [0 0 0 0 0 1];
        % ["T11" "T22" "T12" "V1" "V2" "V"];

        % Type of source terms
        % 1: source term in the equations (default)
        % 2: forced values
        TypeSourceTerms (1,1) uint8; 
    end
end