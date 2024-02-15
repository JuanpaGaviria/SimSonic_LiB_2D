dirInfo = dir;
for i = 1:numel(dirInfo)
    fileName = dirInfo(i).name;
    if  startsWith(fileName,'R') && endsWith(fileName,'.rcv2D')
        outputSignal = SimSonic2DReadRcv2D(fileName);
        temporalStep = outputSignal.Temporal_step_us;
        timeVector = 0:temporalStep:(numel(outputSignal.Signals)-1)*temporalStep;
        Amplit = outputSignal.Signals;
        M = [timeVector' Amplit];
        writematrix(M,[fileName(1:end-6) '.txt'],'Delimiter','tab')
    end
end
