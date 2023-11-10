%1
clc

b = [1,0]
a = [1,-r0]
zplane(b,a)
title("Pole-Zero plot")
tf(b,a)
r0 = 2.5
n = 1:20;
y = infec(r0,n);

for i = 1:length(y)
    if y(i) >= 1000000
        i
        break
    end
end


r0=2.5
n=1:20
new = r0.^n;
total_infections = (r0.^(n + 1) - 1) / (r0 - 1);
int_filt = @(x) cumsum(x);
total_infections_filt = int_filt(new);

figure;
plot(n, new);
xlabel('Day');
ylabel('Number of new infections');
title('New daily infections');

figure;
plot(n, total_infections_filt);
xlabel('Day');
ylabel('Number of total infections');
title('Total number of infections');


%%
a = [0.1, 0.15, 0.25, 0.26, 0.34, 0.42, 0.25, 0.2, 0.15, 0.1, 0.1, 0.1];

n = 30;

plotInfections(a, n);


function plotInfections(a, n)
    % a: Coefficients for the filter
    % n: Number of days to simulate
    
    % Initialize the filter
    b = 1;  % Numerator coefficients (1 for integrator)
    filterOrder = length(a);
    
    % Generate Kronecker delta input
    delta = zeros(1, n);
    delta(1) = 1;
    
    % Initialize output signals
    newDailyInfections = zeros(1, n);
    totalInfections = zeros(1, n);
    
    % Simulate the response without lsim
    for t = 1:n
        % Update new daily infections
        for k = 1:min(t, filterOrder)
            newDailyInfections(t) = newDailyInfections(t) + a(k) * delta(t - k + 1);
        end
        
        % Update total infections
        if t > 1
            totalInfections(t) = totalInfections(t - 1) + newDailyInfections(t);
        else
            totalInfections(t) = newDailyInfections(t);
        end
    end
    
    % Plot new daily infections
    figure;
    subplot(2,1,1);
    plot(newDailyInfections);
    title('New Daily Infections');
    xlabel('Number of Days');
    ylabel('Infections');
    
    % Plot total infections
    subplot(2,1,2);
    plot(totalInfections);
    title('Total Infections');
    xlabel('Number of Days');
    ylabel('Infections');
end

%%
%3
% Coefficients for the filter
a = [0.1, 0.15, 0.25, 0.26, 0.34, 0.42, 0.25, 0.2, 0.15, 0.1, 0.1, 0.1];

% Multiplicative factor
p = 0.75;

% Number of days to simulate
n = 100;

% Plot infections with modified coefficients
plotInfectionsWithMultiplication(a, p, n);


function plotInfectionsWithMultiplication(a, p, n)
    % a: Coefficients for the filter
    % rho: Multiplicative factor
    % n: Number of days to simulate
    
    % Apply the multiplication to coefficients
    a_modified = (1 - p) * a;
    
    % Initialize the filter
    b = 1;  % Numerator coefficients (1 for integrator)
    filterOrder = length(a_modified);
    
    % Generate Kronecker delta input
    delta = zeros(1, n);
    delta(1) = 1;
    
    % Initialize output signals
    newDailyInfections = zeros(1, n);
    totalInfections = zeros(1, n);
    
    % Simulate the response without lsim
    for t = 1:n
        % Update new daily infections
        for k = 1:min(t, filterOrder)
            newDailyInfections(t) = newDailyInfections(t) + a_modified(k) * delta(t - k + 1);
        end
        
        % Update total infections
        if t > 1
            totalInfections(t) = totalInfections(t - 1) + newDailyInfections(t);
        else
            totalInfections(t) = newDailyInfections(t);
        end
    end
    
    % Plot new daily infections
 
    figure;
    subplot(2,1,1);
    plot(newDailyInfections);
    title('Number of New Daily Infections for p = 0.25');
    xlabel('Number of Days');
    ylabel('Number of Infections');
    
    % Plot total infections
    subplot(2,1,2);
    plot(totalInfections);
    title('Total Infections for p = 0.25');
    xlabel('Number of days');
    ylabel('Total Number of Infections');
end
%%
%4
%%%%%%%%% 4
% Define the parameters
R0 = 1.15;
K = 1e6;
n = 100;

% Initialize arrays to store results
y = zeros(n+1, 1);
x = zeros(n+1, 1);

% Initial condition
y(1) = 1;

% Calculate y[n] for the first-order model
for i = 2:n+1
    y(i) = 1 + R0 * y(i - 1);
end

% Calculate x[n] for the logistic model
for i = 1:n+1
    x(i) = K / (1 + (K * (R0 - 1) - R0) * R0^(-i));
end

% Plot the results
figure;
plot(0:n, y, 'b', 'LineWidth', 2, 'DisplayName', 'First-order Model');
hold on;
plot(0:n, x, 'r', 'LineWidth', 2, 'DisplayName', 'Logistic Model');
xlabel('Days');
ylabel('Total Infections');
title('Epidemic Model Comparison');
legend('Location', 'Northwest');

% Find the point of inflection using the first derivative
dy = diff(x);
[~, inflection_day] = max(dy);
inflection_infections = x(inflection_day);

% Find the point of inflection using the second derivative (zero-crossing)
d2y = diff(dy);
zero_crossing_day = find(d2y > 0, 1);

fprintf('Point of Inflection (First Derivative): Day %d, Total Infections %f\n', inflection_day, inflection_infections);
fprintf('Point of Inflection (Zero-Crossing Second Derivative): Day %d, Total Infections %f\n', zero_crossing_day, x(zero_crossing_day));