dirInfo = dir;
figPlot = figure();figPlot.Position = [476 342 827 524];
count = 0;
for i = 1:numel(dirInfo)
    fileName = dirInfo(i).name;
    if  startsWith(fileName,'V_') && endsWith(fileName,'.snp2D')
        disp(fileName)
        snapshot = SimSonic2DReadSnp2D(fileName);
        figPlot;
        imagesc(0:0.0025:20,0:0.0025:20,snapshot.Data);axis image
        ax2=gca;
        set(ax2,'FontSize',axisSize+5,'LineWidth',axisWidth,'TickLabelInterpreter',interpreter,'Box','on')
        xlabel('Distance [mm]','FontSize',axisSize+5,'Interpreter', interpreter)
        ylabel('Distance [mm]','FontSize',axisSize+5,'Interpreter', interpreter)
        count=count+1;
        saveas(figPlot,fullfile('figures',['Snapshot' num2str(count) '.png']))
    end
end