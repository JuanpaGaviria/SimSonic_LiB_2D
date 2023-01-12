function [Signal,NbPts] = SimSonic2DReadSgl(FileName)


%[SIGNAL,NBPTS] = SIMSONIC2DREADSGL(FILENAME) reads FILENAME 
% and returns SIGNAL and its length
%
%   SimSonic2D toolbox
%   Author: Emmanuel Bossy
%   Date: 2012/03/12

fid=fopen(FileName,'rb');
NbPts = fread(fid,1,'int');
Signal = fread(fid,'double');
fclose(fid);


