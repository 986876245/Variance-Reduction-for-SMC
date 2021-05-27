load('E_V_residual_resampling2.mat')

load('E_V_determ_resampling2.mat')

load('E_V_multino_resampling2.mat')

load('E_V_systematic_resampling2.mat')

load('E_V_stra_resampling2.mat')

subplot(5,1,4); 

plot(XX_system,y_system(XX_system),'LineWidth', 1.5, 'Color', 'r')
xlabel('Time'); 
ylabel('Expectation');
title("Systematic resampling")

subplot(5,1,1); 

plot(XX_multino,y_multino(XX_multino),'LineWidth', 1.5, 'Color', 'g')
xlabel('Time'); 
ylabel('Expectation');
title("Multinomial resampling")

subplot(5,1,2); 

plot(XX_residual,y_residual(XX_residual), 'LineWidth', 1.5, 'Color', 'b')
xlabel('Time'); 
ylabel('Expectation');
title("Residual resampling")

subplot(5,1,3); 

plot(XX_stra,y_stra(XX_stra), 'LineWidth', 1.5, 'Color', 'c')
xlabel('Time'); 
ylabel('Expectation');
title("Stratified resampling")

subplot(5,1,5); 


plot(XX_determ,y_determ(XX_determ), 'LineWidth', 1.5, 'Color', 'm')
xlabel('Time'); 
ylabel('Expectation');
title("Our method")
%difference = stateEstPF(2:noObservations) - stateEstKF(2:noObservations);
%plot(1:(noObservations - 1), difference, 'LineWidth', 1.5, 'Color', [117 112 179] / 256);
xlabel('Time'); 
ylabel('Expectation');


figure(2)

%noObservations=100


subplot(5,1,4); 

plot(XX_stra,yvar_system,'LineWidth', 1.5, 'Color', 'r')
xlabel('Time'); 
ylabel('Variance');
title("Systematic resampling")



subplot(5,1,1); 


plot(XX_stra,yvar_multino,'LineWidth', 1.5, 'Color', 'g')
xlabel('Time'); 
ylabel('Variance');
title("Multinomial resampling")


subplot(5,1,2); 

plot(XX_stra,yvar_residual, 'LineWidth', 1.5, 'Color', 'b')
xlabel('Time'); 
ylabel('Variance');
title("Residual resampling")


subplot(5,1,3); 


plot(XX_stra,yvar_stra, 'LineWidth', 1.5, 'Color', 'c')
xlabel('Time'); 
ylabel('Variance');
title("Stratified resampling")

subplot(5,1,5); 

plot(XX_stra,yvar_determ, 'LineWidth', 1.5, 'Color', 'm')
xlabel('Time'); 
ylabel('Variance');

title("Our method")

