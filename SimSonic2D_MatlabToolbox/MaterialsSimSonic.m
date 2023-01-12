classdef MaterialsSimSonic
   
    %UNTITLED13 Summary of this class goes here
    %   Detailed explanation goes here

    properties
        Type            (1,:) char = 'water';
        Index           (1,:) uint64 = 0;
        Density         (1,1) double = 1.0;
        CValues         (1,:) double = [2.25 2.25 2.25 0.0];
    end

    methods
        function obj = MaterialsSimSonic(type,density,cValues)
            obj.Type = type;
            obj.Density = density;
            obj.CValues = cValues;
        end
    end
end