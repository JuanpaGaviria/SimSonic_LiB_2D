function Simsonic2DWriteArray(Array,FileName)

% SIMSONIC2DWRITEARRAY writes RF-signals to formatted array file. The
% format is that of .rcv2D files.
% 
%   SIMSONIC2DWRITEARRAY(ARRAY,FILENAME) writes the content of structure
%   ARRAY to FileName. Array must have the following fields:
%   Normal, X1_start,X2_start, Pitch, Width, 
%   Spatial_step_mm, Temporal_step_us, Signals
%
%   Dimensions of ARRAY.SIGNALS are (Time,Elements)
%
%   IMPORTANT: ARRAY.NORMAL must be a char, i.e. '1' or '2', not 1 or 2....
%
%   SimSonic2D toolbox
%   Author: Emmanuel Bossy
%   Date: 2012/03/12


fid=fopen([FileName],'wb');

fwrite(fid,Array.Normal,'char');
fwrite(fid,size(Array.Signal,2),'int');
fwrite(fid,Array.X1_start,'int');
fwrite(fid,Array.X2_start,'int');
fwrite(fid,Array.Pitch,'int');
fwrite(fid,Array.Width,'int');
fwrite(fid,Array.Spatial_step_mm,'double');
fwrite(fid,size(Array.Signal,1),'int');
fwrite(fid,Temporal_step_us,'double');
fwrite(fid,Array.Signals,'double');

fclose(fid);








