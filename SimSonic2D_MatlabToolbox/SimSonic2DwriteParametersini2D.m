function SimSonic2DwriteParametersini2D(parameters,emitters,receivers,materials,fileName)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
if nargin == 4
    fileName ='Parameters.ini2D';
end

VARarryas = ["T11" "T22" "T12" "V1" "V2"];
VARarryasAumengted = [VARarryas "V"];

X1LowBoundary = parameters.Boundaries(1);
X1HighBoundary = parameters.Boundaries(2);
X2LowBoundary = parameters.Boundaries(3);
X2HighBoundary = parameters.Boundaries(4);


fid = fopen(fileName, 'a+');

fprintf(fid,'**********************************************\n');
fprintf(fid,'************ GENERAL PARAMETERS **************\n');
fprintf(fid,'**********************************************\n');

fprintf(fid,'Grid Step           (mm)     : %5.3f\n',parameters.Grid_step_mm);
fprintf(fid,'Vmax                (mm/us)  : %5.3f\n',parameters.Vmax);
fprintf(fid,'Simulation Length   (us)     : %5.3f\n',parameters.SimulationLen);
fprintf(fid,'CFL Coefficient              : %5.3f\n',parameters.CFLCoefficient);
fprintf(fid,'Absorption Type              : %d\n',parameters.AbsorpType);

fprintf(fid,'\n**********************************************\n');
fprintf(fid,'************** Boundary Conditions *************\n');
fprintf(fid,'**** 0: PML, 1:Symetrical, 2:Free, 3:Rigid *****\n');
fprintf(fid,'************************************************\n\n');
fprintf(fid,'X1_low Boundary              : %d\n',X1LowBoundary);
fprintf(fid,'X1_high Boundary             : %d\n',X1HighBoundary);
fprintf(fid,'X2_low Boundary              : %d\n',X2LowBoundary);
fprintf(fid,'X2_high Boundary             : %d\n',X2HighBoundary);


fprintf(fid,'\n************** PML Parameters ****************\n');

fprintf(fid,'PML Thickness   (grid step)  : %d\n',parameters.PMLThickness);
fprintf(fid,'Vmax in PML     (mm/us)      : %5.3f\n',parameters.VmaxPML);
fprintf(fid,'PML Efficiency     (dB)      : %5.3f\n',parameters.PMLEfficiency);


fprintf(fid,'\n********** TYPE OF SOURCE TERMS  *************\n');
fprintf(fid,'* 1: source term in the equations (default)\n');
fprintf(fid,'* 2: forced values\n');
fprintf(fid,'\n**********************************************\n');
fprintf(fid,'Type of Source Terms         : %d\n',parameters.TypeSourceTerms);


fprintf(fid,'\n*********************************************\n');
fprintf(fid,'***** DEFINITION OF BUILT-IN SOURCE TERMS *****\n');
fprintf(fid,'***********************************************\n');
fprintf(fid,'* Definition of a 1D emitters Array\n\n');

for k = VARarryas
    mask = arrayfun(@(x)strcmp(x.Type, k), emitters);
    emittersFiltered = emitters(mask);
    numEmittersFiltered = numel(emittersFiltered);
    numberBlankSpaces = strlength(k);
    fprintf(fid,'Nb of %s Emitters Arrays%s    : %d\n',k,blanks(3-numberBlankSpaces),numEmittersFiltered);
    for j = 1:numEmittersFiltered
        fprintf(fid,'-1 %s\n',emittersFiltered(j).SignalFileName);
        fprintf(fid,'%d\n',emittersFiltered(j).NormalOrientation);
        fprintf(fid,'%d	%d\n',emittersFiltered(j).Origin);
        fprintf(fid,'%d	%d	%d	%d	%d\n',emittersFiltered(j).ConditionsArray);
        fprintf(fid,'%0.1f	%4.3f\n',emittersFiltered(j).SpecialCondArray);
    end
    fprintf(fid,'\n');
end

fprintf(fid,'\n*********************************************\n');
fprintf(fid,'************* SNAPSHOT RECORDING **************\n');
fprintf(fid,'***********************************************\n\n');

fprintf(fid,'Snapshots Record Period  (us): %d\n\n',parameters.SnapRecordPeriod);
for k = 1:numel(VARarryasAumengted)
    numberBlankSpaces = strlength(VARarryasAumengted(k));
    fprintf(fid,'Record %s Snapshots%s         : %d\n',VARarryasAumengted(k),blanks(3-numberBlankSpaces),parameters.RecordVAR(k));
end
fprintf(fid,'\n*********************************************\n');
fprintf(fid,'******* DEFINITION OF MATERIALS PROPERTIES ****\n');
fprintf(fid,'***********************************************\n');
fprintf(fid,'* Index Density	c11	c22	c12	c66\n\n');

fprintf(fid,'Starts Materials List\n');
for k = 1:numel(materials)
    fprintf(fid,'%d 	%4.2f 	%4.2f 	%4.2f	%4.2f	%4.2f 	%s\n', ...
        materials(k).Index,materials(k).Density,materials(k).CValues(1),materials(k).CValues(2), ...
        materials(k).CValues(3),materials(k).CValues(4),materials(k).Type);
end
fprintf(fid,'Ends Materials List\n');

fprintf(fid,'\n*********************************************\n');
fprintf(fid,'******* DEFINITION OF RECEIVERS ARRAYS ****\n');
fprintf(fid,'***********************************************\n');
fprintf(fid,'* Definition of a 1D receivers Array\n\n');


for k = VARarryas
    mask = arrayfun(@(x)strcmp(x.Type, k), receivers);
    receiversFiltered = receivers(mask);
    numReceiversFiltered = numel(receiversFiltered);
    numberBlankSpaces = strlength(k);
    fprintf(fid,'Nb of %s Receivers Array%s    : %d\n',k,blanks(3-numberBlankSpaces),numReceiversFiltered);
    for j = 1:numReceiversFiltered
        fprintf(fid,'%s\n',receiversFiltered(j).FileNameToSave);
        fprintf(fid,'%d\n',receiversFiltered(j).NormalOrientation);
        fprintf(fid,'%d	%d\n',receiversFiltered(j).Origin);
        fprintf(fid,'%d	%d	%d\n',receiversFiltered(j).ConditionsArray);
    end
    fprintf(fid,'\n');
end

fclose(fid);

end