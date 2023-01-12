function [Map,Nx,Ny] = SimSonic2DReadMap2D(FileName,DownSamplingFactor)

% SIMSONIC2DREADMAP2D reads .map2D geometry file
%
%   [MAP,N1,N2] = SIMSONIC2DREADMAP2D(FILENAME) returns
%   MAP as a uint8 matrix with size(Map)=[N1 N2];
%
%   [MAP,N1,N2] = SIMSONIC2DREADMAP2D(FILENAME,DOWNSAMPLINGFACTOR)returns
%   MAP as a uint8 matrix with size(Map)=floor([N1 N2]/DOWNSAMPLINGFACTOR);
%
%   DOWNSAMPLINGFACTOR must be a positive integer. When reading 'FileName',
%   only one point is read every DOWNSAMPLINGFACTOR points.
%
%   SimSonic2D toolbox
%   Author: Emmanuel Bossy
%   Date: 2012/03/12

if nargin<2
    DownSamplingFactor=1;
elseif ~(DownSamplingFactor==max(round(abs(DownSamplingFactor)),1))
    error('DOWNSAMPLINGFACTOR must be a positive integer...')
end


fid=fopen(FileName,'rb');
Nx = fread(fid,1,'int');
Ny = fread (fid,1,'int');

sizeofint=4;

if DownSamplingFactor>1
    Map=repmat(uint8(0),floor(Nx/DownSamplingFactor),floor(Ny/DownSamplingFactor));
    for idx=1:floor(Nx/DownSamplingFactor)
        temp=fread(fid,floor(Ny/DownSamplingFactor),'uchar',(DownSamplingFactor-1));
        Map(idx,:)=temp';
        fseek(fid,idx*Ny*(DownSamplingFactor)+2*sizeofint,'bof');
    end
else
    Map=repmat(uint8(0),Nx,Ny);
    Map=uint8(fread(fid,'uchar'));
    Map=reshape(Map,Ny,Nx);
    Map=permute(Map,[2 1]);
end

fclose(fid);

