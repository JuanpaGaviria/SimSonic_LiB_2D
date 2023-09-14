% If your image file starts with image_1.png, image_2.png and so on ...
% and live in the current folder.
folder = 'figures'; % Or wherever you want.
video = VideoWriter('SimulationVideo5','MPEG-4'); % Create the video object.
video.FrameRate = 5;
open(video); % Open the file for writing
N=99; % Where N is the separate number of PNG image files.
for k = 1 : N 
    I = imread(fullfile(folder,['Snapshot' num2str(k) '.png']),'png'); % Read the next image from disk.
    writeVideo(video,I); % Write the image to file.
end
close(video);