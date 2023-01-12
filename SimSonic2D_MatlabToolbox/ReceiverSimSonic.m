classdef ReceiverSimSonic
   
    %UNTITLED13 Summary of this class goes here
    %   Detailed explanation goes here

    properties
        Type                (1,:) char = 'T11';
        FileNameToSave      (1,:) char = 'R001';
        NormalOrientation   (1,1) uint8 = 1;
        Origin              (1,2) uint64 = [980 500];
        ConditionsArray     (1,3) uint64 = [1 1 1];
    end

    methods
        function obj = ReceiverSimSonic(type,fileName)
            obj.Type = type;
            obj.FileNameToSave = fileName;
        end
    end
end