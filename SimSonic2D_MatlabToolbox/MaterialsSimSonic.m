classdef MaterialsSimSonic
   
    %UNTITLED13 Summary of this class goes here
    %   Detailed explanation goes here

    properties
        Type            (1,:) char;
        Index           (1,:) uint64;
        Density         (1,1) double;
        CValues         (1,:) double;
    end

    methods
        function obj = MaterialsSimSonic(type,index,density,cValues)
            obj.Type = type;
            obj.Index = index;
            obj.Density = density;
            obj.CValues = cValues;
        end
    end
end