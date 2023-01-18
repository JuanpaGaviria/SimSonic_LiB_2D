classdef ReceiverSimSonic
   
    %UNTITLED13 Summary of this class goes here
    %   Detailed explanation goes here

    properties
        Type                (1,:) char;
        FileNameToSave      (1,:) char;
        NormalOrientation   (1,1) uint8;
        Origin              (1,2) uint64;
        ConditionsArray     (1,3) uint64;
    end

    methods
        function obj = ReceiverSimSonic(type,fileName)
            obj.Type = type;
            obj.FileNameToSave = fileName;
        end
    end
end