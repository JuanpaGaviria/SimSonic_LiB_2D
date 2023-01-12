function Snapshot = SimSonic2DReadSnp2D(FileName,Option)

% SIMSONIC2DREADSNP2D reads .snp2D snapshot file
%
%   SNAPSHOT = SIMSONIC2DREADSNP2D(FILENAME) reads FileName into a
%   structure SNAPSHOT
%
%   SNAPSHOT = SIMSONIC2DREADSNP2D(FILENAME,'plot') reads
%   FileName into a structure SNAPSHOT and plots the data.
%
%   SNAPSHOT = SIMSONIC2DREADSNP2D(FILENAME,DOWNSAMPLINGFACTOR) reads
%   FileName into a structure SNAPSHOT. DOWNSAMPLINGFACTOR must be a
%   positive integer, used to spatially downsample the data
%
%   SNAPSHOT = SIMSONIC2DREADSNP2D(FILENAME,REGIONOFINTEREST) reads
%   FileName into a structure SNAPSHOT, extracting only the data
%   specified in REGIONOFINTEREST. REGIONOFINTEREST must be a structure
%   with the following fields:
%   REGIONOFINTEREST.Xstart, REGIONOFINTEREST.Xend
%   REGIONOFINTEREST.Ystart, REGIONOFINTEREST.Yend
%
%   SimSonic2D toolbox
%   Author: Emmanuel Bossy
%   Date: 2012/03/12

fid=fopen(FileName,'rb');

if fid==-1
    error('File not found...');
end

NX=fread(fid,1,'int');
NY=fread(fid,1,'int');
t=fread(fid,1,'double');
H=fread(fid,1,'double');
DeltaT=fread(fid,1,'double');

if nargin<2
    image=single(fread(fid,'float32'));
    image=reshape(image,NY,NX);
    image=permute(image,[2 1]);
    Option=1;
    DownSamplingFactor=Option;
    Max=max(abs(image(:)));
else
    if isstruct(Option)
        ROI=Option;
        image=repmat(single(0),[ROI.Xend-ROI.Xstart+1 ROI.Yend-ROI.Ystart+1]);
        for idx=1:(ROI.Xend-ROI.Xstart+1)
            PosInFile=2*4+3*8+(ROI.Xstart+idx-1-1)*NY*4+(ROI.Ystart-1)*4;
            fseek(fid,PosInFile,'bof');
            temp=single(fread(fid,ROI.Yend-ROI.Ystart+1,'float32'));
            image(idx,:)=temp';
        end
        Max=max(abs(image(:)));
        
    elseif isa(Option,'char')
        
        image=single(fread(fid,'float32'));
        image=reshape(image,NY,NX);
        image=permute(image,[2 1]);
        Max=max(abs(image(:)));
        DownSamplingFactor=1;
        %figure(1);
        colormap(gray);imagesc(image);axis image;title(sprintf('max = %f',Max));
    else
        DownSamplingFactor=Option;
        if DownSamplingFactor>1
            image=repmat(single(0),[floor(NX/DownSamplingFactor) floor(NY/DownSamplingFactor)]);
            for idx=1:NX/DownSamplingFactor
                temp=single(fread(fid,floor(NY/DownSamplingFactor),'float32',(DownSamplingFactor-1)*4));
                image(idx,:)=temp';
                fseek(fid,idx*NY*4*(DownSamplingFactor)+2*4+3*8,'bof');
            end
            Max=max(abs(image(:)));
            
        else
            image=single(fread(fid,'float32'));
            image=reshape(image,NY,NX);
            image=permute(image,[2 1]);
            Max=max(abs(image(:)));
            
        end
    end
end

fclose(fid);

% ****** CREATES OUTPUT STRUCTURE ********************************

if isstruct(Option)
    Snapshot=struct(...
        'DwnSmpl',1,...
        'ROI',ROI,...
        'N1',ROI.Xend-ROI.Xstart+1,...
        'N2',ROI.Yend-ROI.Ystart+1,...
        'Time_us',t,...
        'Grid_step_mm',H,...
        'Time_step_us',DeltaT,...
        'Data',image,...
        'Max',Max);
else
    Snapshot=struct(...
        'DwnSmpl',DownSamplingFactor,...
        'N1',floor(NX/DownSamplingFactor),...
        'N2',floor(NY/DownSamplingFactor),...
        'Time_us',t,...
        'Grid_step_mm',H,...
        'Time_step_us',DeltaT,...
        'Data',image,...
        'Max',Max);
end
