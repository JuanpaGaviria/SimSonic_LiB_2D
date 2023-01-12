function SimSonic2DWriteMap2D(Map,FileName)

% SIMSONIC2DWRITEMAP writes .map2D geometry file from a matrix
%
%   SIMSONIC2DWRITEMAP(MAP) writes MAP into a file named "Geometry.map2D"
%   
%   MAP must be a uint8 matrix;
%   
%   SIMSONIC2DWRITEMAP(MAP,FILENAME) writes MAP into a file named using
%   FILENAME
%
%   SimSonic2D toolbox
%   Author: Emmanuel Bossy
%   Date: 2012/03/12

if nargin==1
    FileName='Geometry.map2D';
end

if ~isa(Map,'uint8')
    error('geometry file must be of uint8...');
end

[X,Y]=size(Map);

Map=permute(Map,[2 1]);

fid=fopen(FileName,'w+b');
fwrite(fid,X,'int');
fwrite(fid,Y,'int');
fwrite(fid,Map,'uchar');
fclose(fid);
