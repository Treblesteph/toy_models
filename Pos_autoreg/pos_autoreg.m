% Toy model of the dynamics of a single gene positive autoregulation model.
% Single gene (G) which upregulates itself according to a Hill function
% with Hill coefficient of 4.

function [output] = pos_autoreg()

% Parameters (rates in millimoles per second).
DEGRAD = 1 / 3600; % Assumed that cell cycle length is an hour.
BASAL_TRANS = 0 + rand * 0.00027;
MAX_G = 0.008;
CONC_ACT = 24;
HILL = 4;
INIT_G = 0;
ALLTIME = 1000 * 3600; % Simulation run for 200 cell cycles.

[TIME, G] = ode23(@diffeqn, [0, ALLTIME], INIT_G);

    function dGdt = diffeqn(TIME, G)
        dGdt = BASAL_TRANS + ((MAX_G * (G ^ HILL)) / (CONC_ACT + ...
                    (G ^ HILL))) - G * DEGRAD;
    end
figure(3)
plot(TIME, G)
end