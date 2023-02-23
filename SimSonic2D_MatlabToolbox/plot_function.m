dirInfo = dir;
figPlot = figure();
for i = 1:numel(dirInfo)
    fileName = dirInfo(i).name;
    if  startsWith(fileName,'V_') && endsWith(fileName,'.snp2D') 
        disp(fileName)
       snapshot = SimSonic2DReadSnp2D(fileName);
       figPlot;imagesc(snapshot.Data)
       pause(0.001)
    end
end