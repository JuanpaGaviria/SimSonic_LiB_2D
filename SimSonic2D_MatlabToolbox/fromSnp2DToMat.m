% Script to convert SimSonic Data to Matfile
count = 1;
dirInfo = dir;

for i = 1:numel(dirInfo)
    fileName = dirInfo(i).name;
    if  startsWith(fileName,'V_') && endsWith(fileName,'.snp2D')
        disp(fileName)
        snapshot = SimSonic2DReadSnp2D(fileName);
        save(['figures/snapshot_' num2str(count)],'snapshot')
        count = count +1;
        delete(fileName)
    end
end