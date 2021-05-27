
% Set random seed
rng(0)
addpath("/home/daixiongming/Downloads/Matlab-master")
addpath("/home/xiongming/Downloads/V1_1_urlread2")
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Load data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%data=Quandl.get('NASDAQOMX/OMXS30', 'authcode', 'CyzgihyVzJC3pYHR16Jt')

Quandl.api_key('CyzgihyVzJC3pYHR16Jt')
%Quandl.api_key('CyzgihyVzJC3pYHR16Jt')
%data = Quandl.get('NASDAQOMX/OMXS30', 'start_date', '2012-01-02', 'end_date', '2014-01-02', 'type', 'data'); 
data = Quandl.get('NASDAQOMX/OMXS30', 'start_date', '2015-01-02', 'end_date', '2016-01-02', 'type', 'data'); 

logReturns = 100 * diff(log(flipud(data(:, 2))));
noObservations = length(logReturns);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PMH
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
initialTheta  = [0 0.9 0.2];
%noParticles = 500; % Use noParticles ~ noObservations

noParticles=25

%noBurnInIterations = 2500;
%noIterations = 7500;
noBurnInIterations = 25;
noIterations = 75;
stepSize = diag([0.10 0.01 0.05].^2);

[parameterTrace, logVolatilityEstimate,BeforeResampling,AfterResampling] = particleMetropolisHastingsSVmodel(logReturns, initialTheta, noParticles, noIterations, stepSize);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot the results
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
grid = noBurnInIterations:noIterations;
noBins = floor(sqrt(noIterations - noBurnInIterations));
logVolatilityEstimate = logVolatilityEstimate(grid, 2:(noObservations + 1));
parameterTrace = parameterTrace(grid, :);

figure(1)
% Plot the log-returns
subplot(4, 1, 1);
plot(logReturns, 'LineWidth', 1.5, 'Color', [0.3010 0.7450 0.9330])
xlabel('Time'); 
ylabel('y_t');
title("log-returns")

% Plot the log-volatility
subplot(4, 1, 2);
plot(mean(logVolatilityEstimate, 1), 'LineWidth', 1.5, 'Color', [0.4940 0.1840 0.5560])
xlabel('Time'); 
ylabel('X_t');
title("log-volatility estimate")



x=mean(BeforeResampling)
xvar=var(BeforeResampling)
XX=1:noObservations;
%plot(1:250,x)

subplot(4, 1, 3);
plot(XX,x(XX),'LineWidth', 1.5, 'Color', [0.4660 0.6740 0.1880]);
xlabel('Time'); 
ylabel('Expectation');
ylim([0.02 0.06])
title("Expectation before resampling")

subplot(4, 1, 4);

plot(1:noObservations,xvar,'LineWidth', 1.5, 'Color', [0.6350 0.0780 0.1840])
xlabel('Time'); 
ylabel('Variance');
title("Variance before resampling")


y=mean(AfterResampling)
yvar=var(AfterResampling)

%figure on;
%plot(1:250,y)

figure(2)
plot(XX,y(XX))
xlabel('Time'); 
ylabel('Expectation after resampling');

%hold off;

figure(3)


plot(1:noObservations,yvar)
%plot(1:250,yvar)
xlabel('Time'); 
ylabel('Variance after resampling');

XX_determ=XX
y_determ=y
yvar_determ=yvar

% 
% XX_multino=XX
% y_multino=y
% yvar_multino=yvar


% XX_residual=XX
% y_residual=y
% yvar_residual=yvar


% XX_stra=XX
% y_stra=y
% yvar_stra=yvar

% XX_system=XX
% y_system=y
% yvar_system=yvar



%save('E_V_residual_resampling2.mat','XX_residual','y_residual','yvar_residual')

save('E_V_determ_resampling2.mat','XX_determ','y_determ','yvar_determ')


%save('E_V_multino_resampling2.mat','XX_multino','y_multino','yvar_multino')

%save('E_V_systematic_resampling2.mat','XX_system','y_system','yvar_system')

%save('E_V_stra_resampling2.mat','XX_stra','y_stra','yvar_stra')











% 
% 
% figure(4)
% 
% 
% 
% 
% 
% 
% % Histogram of marginal parameter posterior of mu
% %subplot(5, 3, 7);
% hist(parameterTrace(:, 1), noBins);
% xlabel('mu'); 
% ylabel('posterior density estimate');
% 
% h = findobj(gca, 'Type', 'patch');
% set(h, 'FaceColor', [117 112 179] / 256, 'EdgeColor', 'w');
% hold on; 
% plot([1 1] * mean(parameterTrace(:, 1)), [0 500], 'k'); 
% hold off;
% 
% % Trace plot for mu
% %subplot(5, 3, 8);
% figure(5)
% plot(grid, parameterTrace(:, 1), 'Color', [117 112 179] / 256);
% hold on; 
% plot([grid(1) grid(end)], [1 1] * mean(parameterTrace(:, 1)), 'k'); 
% hold off;
% xlabel('iteration'); 
% ylabel('trace of mu');
% 
% % Plot ACF of the Markov chain for mu after burn-in
% %subplot(5, 3, 9);
% figure(6)
% [acf, lags] = xcorr(parameterTrace(:, 1) - mean(parameterTrace(:, 1)), 100, 'coeff');
% stem(lags(101:200), acf(101:200), 'Color', [117 112 179] / 256, 'LineWidth', 2);
% xlabel('lag'); 
% ylabel('ACF of mu');
% 
% % Histogram of marginal parameter posterior of phi
% %subplot(5, 3, 10);
% figure(7)
% hist(parameterTrace(:, 2), noBins);
% xlabel('phi'); 
% ylabel('posterior density estimate');
% 
% h = findobj(gca, 'Type', 'patch');
% set(h, 'FaceColor', [231 41 138] / 256, 'EdgeColor', 'w');
% hold on; 
% plot([1 1] * mean(parameterTrace(:, 2)), [0 500], 'k'); 
% hold off;
% 
% % Trace plot for phi
% %subplot(5, 3, 11);
% figure(8)
% plot(grid, parameterTrace(:, 2), 'Color', [231 41 138] / 256);
% xlabel('iteration'); 
% ylabel('trace of phi');
% hold on; 
% plot([grid(1) grid(end)],[1 1] * mean(parameterTrace(:, 2)), 'k'); 
% hold off;
% 
% % Plot ACF of the Markov chain for phi after burn-in
% %subplot(5, 3, 12);
% figure(9)
% [acf, lags] = xcorr(parameterTrace(:, 2) - mean(parameterTrace(:, 2)), 100, 'coeff');
% stem(lags(101:200), acf(101:200), 'Color', [231 41 138] / 256, 'LineWidth', 2);
% xlabel('lag'); 
% ylabel('ACF of phi');
% 
% % Histogram of marginal parameter posterior of sigma_v
% %subplot(5, 3, 13);
% figure(10)
% hist(parameterTrace(:, 3), noBins);
% xlabel('sigmav'); 
% ylabel('posterior density estimate');
% 
% h = findobj(gca, 'Type', 'patch');
% set(h, 'FaceColor', [102 166 30] / 256, 'EdgeColor', 'w');
% hold on; 
% plot([1 1] * mean(parameterTrace(:, 3)), [0 500], 'k'); 
% hold off;
% 
% % Trace plot of sigma_v
% %subplot(5, 3, 14);
% figure(11)
% plot(grid, parameterTrace(:, 3), 'Color', [102 166 30] / 256);
% hold on; 
% plot([grid(1) grid(end)],[1 1] * mean(parameterTrace(:, 3)), 'k'); 
% hold off;
% xlabel('iteration'); 
% ylabel('trace of sigmav');
% 
% % Plot ACF of the Markov chain of sigma_v after burn-in
% %subplot(5, 3, 15);
% figure(12)
% [acf, lags] = xcorr(parameterTrace(:, 3) - mean(parameterTrace(:, 3)), 100, 'coeff');
% stem(lags(101:200), acf(101:200), 'Color', [102 166 30] / 256, 'LineWidth', 2);
% xlabel('lag'); 
% ylabel('ACF of sigmav');
