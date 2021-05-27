
% Set random seed
rng(0)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Define the model and generate data
% x[t + 1] = phi * x[t] + sigmav * v[t],    v[t] ~ N(0, 1)
% y[t] = x[t] + sigmae * e[t],              e[t] ~ N(0, 1)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
phi = 0.65;
sigmav = 1.0;
sigmae = 0.10;
parameters = [phi sigmav sigmae];
noObservations = 100;
initialState = 0;

[states, observations] = generateData(parameters, noObservations, initialState);
% https://ww2.mathworks.cn/help/matlab/ref/figure.html

subplot(5,1,1); 
plot(observations(2:(noObservations + 1)), 'LineWidth', 1.5, 'Color', [0 0.4470 0.7410]); 
xlabel('Time'); 
ylabel('y_t');
title("Observations")

subplot(5,1,2); 
plot(states(2:(noObservations + 1)), 'LineWidth', 1.5, 'Color', [0.8500 0.3250 0.0980]); 
xlabel('Time'); 
ylabel('X_t');
title("Estimations")

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% State estimation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Particle filter with N = 20 particles
[stateEstPF,logLikelihood,BeforeResampling,AfterResampling,TT]= particleFilter(observations, parameters, 20, initialState);

% Kalman filter
stateEstKF = kalmanFilter(observations, parameters, initialState, 0.01);
subplot(5,1,3); 
difference = stateEstPF(2:noObservations) - stateEstKF(2:noObservations);
plot(1:(noObservations - 1), difference, 'LineWidth', 1.5, 'Color', [0.4940 0.1840 0.5560]);
xlabel('Time'); 
ylabel('Error');
title("Errors from sequential Monte Carlo")


subplot(5,1,4); 

x=mean(BeforeResampling)
xvar=var(BeforeResampling)
XX=1:noObservations-1;
%plot(1:250,x)
plot(XX,x(XX),'LineWidth', 1.5, 'Color', [0.4660 0.6740 0.1880]);
xlabel('Time'); 
ylabel('Expectation');
ylim([0.04 0.06])
title("Expectation before resampling")


RSME_stratified=sum(difference.^2).^0.5

subplot(5,1,5); 

plot(1:noObservations,xvar,'LineWidth', 1.5, 'Color', [0.6350 0.0780 0.1840])
xlabel('Time'); 
ylabel('Variance');
title("Variance before resampling")


figure(2)

% x=mean(BeforeResampling)
% xvar=var(BeforeResampling)
% XX=1:noObservations-1;
% %plot(1:250,x)
% plot(XX,x(XX))
% xlabel('before resampling'); 
% ylabel('error');

%plot(1:250,xvar)

%plot(1:noObservations,xvar)

%hold on;
y=mean(AfterResampling)
yvar=var(AfterResampling)

%figure on;
%plot(1:250,y)

plot(XX,y(XX))
xlabel('Time'); 
ylabel('Expectation after resampling');

%hold off;

figure(3)


plot(1:noObservations,yvar)
%plot(1:250,yvar)
xlabel('Time'); 
ylabel('Variance after resampling');

XX_stra=XX
y_stra=y
yvar_stra=yvar


% XX_multino=XX
% y_multino=y
% yvar_multino=yvar


% XX_residual=XX
% y_residual=y
% yvar_residual=yvar

%save('E_V_residual_resampling.mat','XX_residual','y_residual','yvar_residual')

%save('E_V_determ_resampling.mat','XX_determ','y_determ','yvar_determ')


%save('E_V_multino_resampling.mat','XX_multino','y_multino','yvar_multino')

%save('E_V_systematic_resampling.mat','XX_system','y_system','yvar_system')

%save('E_V_stra_resampling.mat','XX_stra','y_stra','yvar_stra')
TTsum=sum(TT)

