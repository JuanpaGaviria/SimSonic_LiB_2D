classdef EmitterSimSonic
    %UNTITLED13 Summary of this class goes here
    %   Detailed explanation goes here

    properties
        Type                (1,:) char;
        SignalFileName      (1,:) char = 'signal.sgl';
        NormalOrientation   (1,1) uint8;
        Origin              (1,2) uint64;
        ConditionsArray     (1,5) uint64;
        SpecialCondArray    (1,2) double = [0,1.5];
    end

    methods
        function obj = EmitterSimSonic(type)
            obj.Type = type;
        end
    end
end