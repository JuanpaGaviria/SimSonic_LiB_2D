function Array = SimSonic2DReadRcv2D(FileName)

% SIMSONICREADRCV2D reads .rcv2D file (receiving array)
%
%   ARRAY = SIMSONICREADRCV2D(FILENAME) reads FILENAME into a
%   structure ARRAY
%
%   SimSonic2D toolbox
%   Author: Emmanuel Bossy
%   Date: 2012/03/12


fid=fopen(FileName,'rb');

if fid==-1
    error('File not found...');
end


Normale=char(fread(fid,1,'char'));
NbElements=fread(fid,1,'int');
Xbar = fread(fid,1,'int');
Ybar = fread(fid,1,'int');
Pitch = fread(fid,1,'int');
Largeur = fread(fid,1,'int');
H = fread(fid,1,'double');
IndiceTempsMax=fread(fid,1,'int');
DeltaT=fread(fid,1,'double');
Signal=fread(fid,'double');
fclose(fid);

Signal=reshape(Signal,IndiceTempsMax,NbElements);

Array=struct(...
    'Normal',Normale,...
    'NbElements',NbElements,...
    'X1_start',Xbar,...
    'X2_start',Ybar,...
    'Pitch',Pitch,...
    'Width',Largeur,...
    'Spatial_step_mm',H,...
    'Temporal_step_us',DeltaT,...
    'NbTimePoints',IndiceTempsMax,....
    'Signals',Signal);






