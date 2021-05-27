% load('E_V_residual_resampling.mat')
% 
% load('E_V_determ_resampling.mat')
% 
% load('E_V_multino_resampling.mat')
% 
% load('E_V_systematic_resampling.mat')
% 
% load('E_V_stra_resampling.mat')


X=[5 50 150 300 2000 3000 4000 6000 10000]

y_t_multi=[0.0022 0.0053 0.0156 0.0161 0.3727 0.4479 1.4076 3.0826 8.5190]

y_t_resi=[0.0012 0.0014 0.0028 0.0203 0.2388 0.4286 0.6940 1.4911 4.1171]

y_t_sys=[0.0013 0.0019 0.0024 0.0032 0.0102 0.0118 0.0140 0.0247 0.0280]

y_t_stra=[0.0015 0.0043 0.0083 0.0172 0.0189 0.0220 0.0288 0.0357 0.0545]

y_t_our=[0.0013 0.0016 0.0024 0.0057 0.1464 0.2811 0.4799 1.0677 2.8435]






figure(1)

%subplot(5,1,4); 

%plot(X,y_t_sys,'LineWidth', 1.5, 'Color', [17 151 179] / 256)

plot(X,y_t_sys,'LineWidth', 1.5, 'Color', 'r')

xlabel('Time'); 
ylabel('Expectation');
title("Systematic resampling")

%subplot(5,1,1); 
hold on;

plot(X,y_t_multi,'LineWidth', 1.5, 'Color', 'g')
xlabel('Time'); 
ylabel('Expectation');
title("Multinomial resampling")

hold on;
%subplot(5,1,2); 

plot(X,y_t_resi, 'LineWidth', 1.5, 'Color', 'b')
xlabel('Time'); 
ylabel('Expectation');
title("Residual resampling")

hold on;
%subplot(5,1,3); 

plot(X,y_t_stra, 'LineWidth', 1.5, 'Color', 'c')
xlabel('Time'); 
ylabel('Expectation');
title("Stratified resampling")

hold on;
%subplot(5,1,5); 


plot(X,y_t_our, 'LineWidth', 1.5, 'Color', 'm')
xlabel('Time'); 
ylabel('Expectation');
title("Time Complexity Comparison")
%difference = stateEstPF(2:noObservations) - stateEstKF(2:noObservations);
%plot(1:(noObservations - 1), difference, 'LineWidth', 1.5, 'Color', [117 112 179] / 256);
xlabel('# of particles'); 
ylabel('Time');

legend('Systematic resampling','Multinomial resampling','Residual resampling','Stratified resampling','Our method')

%system("kill")


figure(2)

X_for_error=[5 10 15 20 25 30 40 60]
y_error_sys=[0.4906 0.3231 0.2773 0.2487 0.2131 0.1979 0.1504 0.1281]

y_error_resi=[0.4825 0.3476 0.2515 0.2397 0.1981 0.1913 0.1632 0.1204]


y_error_multi=[0.4381 0.3104 0.2712 0.2133 0.2178 0.1882 0.1477 0.1164]

y_error_stra=[0.4379 0.3106 0.2712 0.2134 0.2180 0.1884 0.1477 0.1166]

y_error_our=[0.4881 0.3438 0.2553 0.2415 0.1985 0.1882 0.1655 0.1206]





subplot(5,1,4); 

%plot(X,y_t_sys,'LineWidth', 1.5, 'Color', [17 151 179] / 256)

plot(X_for_error,y_error_sys,'LineWidth', 1.5, 'Color', 'r')

xlabel('# of particles'); 
ylabel('Error');
title("Systematic resampling")

subplot(5,1,1); 
%hold on;

plot(X_for_error,y_error_multi,'LineWidth', 1.5, 'Color', 'g')
xlabel('# of particles'); 
ylabel('Error');
title("Multinomial resampling")

%hold on;
subplot(5,1,2); 

plot(X_for_error,y_error_resi, 'LineWidth', 1.5, 'Color', 'b')
xlabel('# of particles'); 
ylabel('Error');
title("Residual resampling")

%hold on;
subplot(5,1,3); 

plot(X_for_error,y_error_stra, 'LineWidth', 1.5, 'Color', 'c')
xlabel('# of particles'); 
ylabel('Error');
title("Stratified resampling")

%hold on;
subplot(5,1,5); 


plot(X_for_error,y_error_our, 'LineWidth', 1.5, 'Color', 'm')
xlabel('# of particles'); 
ylabel('Expectation');
title("our method")
%difference = stateEstPF(2:noObservations) - stateEstKF(2:noObservations);
%plot(1:(noObservations - 1), difference, 'LineWidth', 1.5, 'Color', [117 112 179] / 256);
xlabel('# of particles'); 
ylabel('Error');

%legend('Systematic resampling','Multinomial resampling','Residual resampling','Stratified resampling','Our method')

%system("kill")








