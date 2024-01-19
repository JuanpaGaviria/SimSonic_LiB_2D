% Script to generate the video
folder = 'figures'; % Or wherever you want.
video = VideoWriter('SimulationVideoNMCParametersSingleEmitterInCase','MPEG-4'); % Create the video object.
video.FrameRate = 5;
open(video); % Open the file for writing
N=99; % Where N is the separate number of PNG image files.
for k = 1 : N 
    I = imread(fullfile(folder,['Snapshot' num2str(k) '.png']),'png'); % Read the next image from disk.
    writeVideo(video,I); % Write the image to file.
end
close(video);