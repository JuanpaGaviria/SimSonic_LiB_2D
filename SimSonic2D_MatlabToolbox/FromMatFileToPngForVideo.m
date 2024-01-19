% Script to generate .png images (for Video) from matfile

% Setting for plotting
graph = GraphSettings;
axisSize = graph.AxisSize;
axisWidth = graph.AxisWidth;
interpreter = graph.Interpreter;
lineWidth = graph.LineWidth;
fontSize = graph.FontSize;

dirInfo = dir('figures/');
figPlot = figure();figPlot.Position = [349 199 790 667];
numberPhotos = 99;

for i = 1:numberPhotos
    fileName = ['figures/snapshot_' num2str(i)];
    %if  startsWith(fileName,'snapshot') && endsWith(fileName,'.mat')

        % Extract data
        disp(fileName)
%         [~,name,ext] = fileparts(fileName);
%         number = sscanf(name,'snapshot_%d');
        load(fileName)
        
        % Draw figure
        figPlot;
        %snapshot.Data(snapshot.Data > 0.004) = 0;
        dataForPlot = snapshot.Data;
        %normSnap = (dataForPlot - min(dataForPlot(:)))/(max(dataForPlot(:)) - min(dataForPlot(:)));
        %normSnap = (dataForPlot - min(dataForPlot(:)))/(max(dataForPlot(:)) - min(dataForPlot(:)));
        imagesc(0:snapshot.Grid_step_mm:20,0:snapshot.Grid_step_mm:20,dataForPlot);
        %colormap winter
        c = colorbar;
        c.TickLabelInterpreter = 'latex';
        clim(gca, [0, 0.0015])
        ax2=gca;
        set(ax2,'FontSize',axisSize+5,'LineWidth',axisWidth,'TickLabelInterpreter',interpreter,'Box','on')
        xlabel('Distance [mm]','FontSize',axisSize+5,'Interpreter', interpreter)
        ylabel('Distance [mm]','FontSize',axisSize+5,'Interpreter', interpreter)

        title([sprintf('Simulation time %.2f', snapshot.Time_us) ' $\mu$s'],'FontSize',axisSize+5,'Interpreter', interpreter)
        

        % A cada pixel restarle el offset (en la matriz volumetrica) y a
        % cada pixel se le quita el minimo

        % Ver desplazamiento luego de integrar las velocidades de desplazamiento (Vi)

        %pause(0.001)
        % Save images
        %saveas(figPlot,fullfile('figures',['Snapshot' num2str(i) '.png']))
    %end
end