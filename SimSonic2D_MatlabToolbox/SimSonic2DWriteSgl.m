function SimSonic2DWriteSgl(Signal,FileName)

% SIMSONIC2DWRITESGL writes .sgl signal file from a column vector
%
%   SIMSONIC2DWRITESGL(SIGNAL) writes SIGNAL into a file named "Signal.sgl"
%   
%   SIGNAL must be a column vector;
%   
%   SIMSONIC2DWRITESGL(SIGNAL,FILENAME) writes SIGNAL into a file named using
%   FILENAME
%
%   SimSonic2D toolbox
%   Author: Emmanuel Bossy
%   Date: 2012/03/12


if nargin==1
    FileName='Signal.sgl';
end

if ~(size(Signal,2)==1)
    error('signal must be a column vector');
end

NbPtsSignal=size(Signal,1);

fid=fopen(FileName,'w+b');
fwrite(fid,NbPtsSignal,'int');
fwrite(fid,Signal,'double');
fclose(fid);

