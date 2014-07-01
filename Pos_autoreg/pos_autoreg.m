function pos_autoreg(runs)
%POS_AUTOREG - Toy model of the dynamics of a single gene positive
%autoregulation model.
%
% Single gene (G) which upregulates itself according to a Hill function
% with Hill coefficient of 4.
colours = colourScheme(runs);
cellData = {'TIMES', 'G_CONCS'};
for n = 1 : runs
    cellData(1, 2*n-1 : 2*n) = {'TIMES', 'G_CONCS'};
    % Parameters (rates in millimoles per second).
    DEGRAD = 1 / 3600; % Assumed that cell cycle length is an hour.
    BASAL_TRANS = 0 + rand * 0.00027;
    MAX_G = 0.008;
    CONC_ACT = 24;
    HILL = 2;
    INIT_G = 0;
    ALLTIME = 100 * 3600; % Simulation run for 20 cell cycles.
    [TIME, G] = ode23(@diffeqn, [0, ALLTIME], INIT_G);
    figure(3)
    hold on
    plot(TIME, G, 'color', colours(n, :))
    cellData(2:length(TIME)+1, 2*n-1) = num2cell(TIME(:));
    cellData(2:length(TIME)+1, 2*n) = num2cell(G(:));
end
addpath('~/Dropbox/Code/odd_scripts/')
cell2CSV(cellData, 'posAutoData.csv');
function dGdt = diffeqn(~, G)
    dGdt = BASAL_TRANS + ((MAX_G * (G ^ HILL)) / (CONC_ACT + ...
           (G ^ HILL))) - G * DEGRAD;
end
end

function colours = colourScheme(runs)
    colours = [0.01,0.8,0.6; ...      % Green
               0.23,0.78,0.75; ...    % Turquoise
               1,0.8,0.2; ...         % Yellow
               1,0.4,0.2; ...         % Orange
               1,0,0; ...             % Red
               0.2,0.4,1; ...         % Blue
               0.6,0.2,1; ...         % Purple
               0.4,0.2,1; ...         % Navy
               1,0.2,0.8];            % Pink
    count1 = 1.1;
    while size(colours, 1) < runs
        colours = cat(1, colours, colours/count1);
        count1 = count1 + 1;
    end
end