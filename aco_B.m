% 基于平面波假设声传播计算声学系数，包括反射系数??????射系数和吸声系??
%   利用双传声器法分离正方向声波，求得声学相关系数???
%   使用方法??
%   1>定义传声器间距mm  采样频率Hz  声速m/s  密度kg/m3 管道面积m.^2
%   2>选择合???的管道面积用于计算声强大小
%   3>获得结果
%
%   Xuxu Compiled

%  READ DATA FROM EXTERNAL FILES!!!
%   mic_1 = readmatrix(workbook);
%   mic_2 = readmatrix(workbook);
%   mic_3 = readmatrix(workbook);
%   mic_4 = readmatrix(workbook); 
  fs = 48000 ;   %the sample frequency like 10000Hz,65536Hz
  start_number = round(48000 * 1.2);
  end_number = start_number + round(1* 35 * 48000)  ;
  mic_1_time = channel5(start_number:end_number);
  mic_2_time = channel6(start_number:end_number);
  mic_3_time = channel2(start_number:end_number);
  mic_4_time = channel1(start_number:end_number);
  mic_5_time = channel4(start_number:end_number);
  mic_6_time = channel3(start_number:end_number);

  mic_1_time = mic_1_time - mean(mic_1_time);
  mic_2_time = mic_2_time - mean(mic_2_time);
  mic_3_time = mic_3_time - mean(mic_3_time);
  mic_4_time = mic_4_time - mean(mic_4_time);
  mic_5_time = mic_5_time - mean(mic_5_time);
  mic_6_time = mic_6_time - mean(mic_6_time);
%  Define Basic parameters  

  L_1 = length(mic_1_time) ;  
  frequency = fs * (0:1:(L_1/2))/L_1 ;
  Y_1 = mic_1_time(1:L_1) ;
  S_1 =fft(Y_1,L_1)./L_1 ;
  P2_1 = S_1 ;
  P1_1 = P2_1(1:L_1/2+1) ;
  P1_1(2:end-1) = 2 * P1_1(2:end-1);
  mic_1 = P1_1  ;
  mic_1_psd = (abs(mic_1)) .^2 ;

  
   clear P1 P2 ;  
  L_2 = length(mic_2_time) ;
  frequency = fs * (0:1:(L_2/2))/L_2 ;
  Y_2 = mic_2_time(1:L_2) ;
  S_2 =fft(Y_2,L_2)./L_2 ;
  P2_2 = S_2 ;
  P1_2 = P2_2(1:L_2/2+1) ;
  P1_2(2:end-1) = 2 * P1_2(2:end-1);
  mic_2 = P1_2  ;
  mic_2_psd = (abs(mic_2)) .^2 ;
  
  clear P1 P2 ;  
  L_3 = length(mic_3_time) ;
  frequency = fs * (0:1:(L_3/2))/L_3 ;
  Y_3 = mic_3_time(1:L_3) ;
  S_3 =fft(Y_3,L_3)./L_3 ;
  P2_3 = S_3 ;
  P1_3 = P2_3(1:L_3/2+1) ;
  P1_3(2:end-1) = 2 * P1_3(2:end-1);
  mic_3 = P1_3  ;
  mic_3_psd = (abs(mic_3)) .^2 ;
  
  clear P1 P2 ;  
   L_4 = length(mic_4_time) ;
  frequency = fs * (0:1:(L_4/2))/L_4 ;
  Y_4 = mic_4_time(1:L_4) ;
  S_4 =fft(Y_4,L_4)./L_4 ;
  P2_4 = S_4 ;
  P1_4 = P2_4(1:L_4/2+1) ;
  P1_4(2:end-1) = 2 * P1_4(2:end-1);
  mic_4 = P1_4 ;
  mic_4_psd = (abs(mic_4)) .^2 ;
  
  clear P1 P2 ;  
  L_5 = length(mic_5_time) ;
  frequency = fs * (0:1:(L_5/2))/L_5 ;
  Y_5 = mic_5_time(1:L_5) ;
  S_5 =fft(Y_5,L_5)./L_5 ;
  P2_5 = S_5 ;
  P1_5 = P2_5(1:L_5/2+1) ;
  P1_5(2:end-1) = 2 * P1_5(2:end-1);
  mic_5 = P1_5 ;
  mic_5_psd = (abs(mic_5)) .^2 ;
  
  clear P1 P2 ;  
  L_6 = length(mic_6_time) ;
  frequency = fs * (0:1:(L_6/2))/L_6 ;
  Y_6 = mic_6_time(1:L_6) ;
  S_6 =fft(Y_6,L_6)./L_6 ;
  P2_6 = S_6 ;
  P1_6 = P2_6(1:L_6/2+1) ;
  P1_6(2:end-1) = 2 * P1_6(2:end-1);
  mic_6 = P1_6 ;
  clear P1 P2 ;  
  mic_6_psd = (abs(mic_6)) .^2 ;
  
% Begin calculation  
% 28.985235    30.15                                   Space
  s = 27.81 / 1000 ;     %the distance between mic /mm
  c = 336.85 ;          %the speed of sound m/s before 347.98
  density = 1.225 ;  %the density of Air in standard temperature
  area_a = 0.0629;    %the pipe named 鍑哄彛绠?1
  area_b = 0.0629;    %the pipe named 鍑哄彛绠?2
  area_c = 0.1219;    %the pipe named 杩涘彛绠?
  K_L = 500/1000 ;
  k = (2*pi*frequency/c)'   ; %the specific number k
  
  fenmu = exp(1j*k*s)-exp(-1j*k*s) ;
  
  P12_plus = (mic_1 .*exp(1j*k*s)- mic_2) ./ (fenmu) ;    %forward acoustic wave
  P12_minus = (mic_2 - mic_1 .*exp(-1j*k*s)) ./ (fenmu) ; %backward acoustic wave
  W12_plus = 0.5.*((abs(P12_plus)).^2).*area_b./(c*density);               %foeward wave power intensity
  W12_minus = 0.5.*((abs(P12_minus)).^2).*area_b./(c*density);             %backward wave power intensity
  r12_raw =  P12_minus ./ P12_plus ;
  r12 = abs( ( W12_minus ./ W12_plus)) ;
  r12_p = abs(( P12_minus ./ P12_plus).*(exp(2j*k*0.002))) ;

  s_2 = 27.81 / 1000;
  fenmu_2 =  exp(1j*k*s_2)-exp(-1j*k*s_2) ;
  P34_plus = (mic_3 .*exp(1j*k*s_2)- mic_4) ./ (fenmu_2) ;    %forward acoustic wave
  P34_minus = (mic_4 - mic_3 .*exp(-1j*k*s_2)) ./ (fenmu_2) ;    %backward acoustic wave
  W34_plus = 0.5.*((abs(P34_plus)).^2).*area_a./(c*density);               %foeward wave power intensity
  W34_minus = 0.5.*((abs(P34_minus)).^2).*area_a./(c*density);             %backward wave power intensity
  r34 = abs( ( W34_minus ./ W34_plus)) ;  %the reflection coefficient in real form ---result_2
  r34_raw = ( ( P34_minus ./ P34_plus)) ;
  
  s_3 = 27.81 / 1000;
  fenmu_3 =  exp(1j*k*s_3)-exp(-1j*k*s_3) ;
  P56_plus = (mic_5 .*exp(1j*k*s_3)- mic_6 ) ./ (fenmu_3) ;    %forward acoustic wave
  P56_minus = (mic_6 - mic_5 .*exp(-1j*k*s_3) ) ./ (fenmu_3) ;    %backward acoustic wave
  W56_plus = 0.5.*((abs(P56_plus)).^2).*area_c./(c*density);               %foeward wave power intensity
  W56_minus = 0.5.*((abs(P56_minus)).^2).*area_c./(c*density);             %backward wave power intensity
  r56 = abs( ( W56_minus ./ W56_plus)) ;  %the reflection coefficient in real form ---result_3
  r56_raw = ( ( P56_minus ./ P56_plus))   ;
  
  
t13 = abs( W34_plus ./ W12_plus )  ;
t15 = abs( W56_plus ./ W12_plus ) ;

% t13 = abs( P34_minus ./ P12_plus )  ;
% t15 = abs( P34_plus ./ P12_plus ) ;

  S34 = mic_3 .* conj(mic_4) ;
  S33 = mic_3 .* conj(mic_3) ;    
  S43 = mic_4 .* conj(mic_3) ;
  S44 = mic_4 .* conj(mic_4) ;
  
  S56 = mic_5 .* conj(mic_6) ;
  S55 = mic_5 .* conj(mic_5) ;    
  S65 = mic_6 .* conj(mic_5) ;
  S66 = mic_6 .* conj(mic_6) ;
  H34 = S34 ./ S33 ;
  H56 = S56 ./ S55 ;
 
figure(8)
plot(frequency,abs(H34)) ; 
title('H34') ;
xlim( [0 500] );
figure(9)
plot(frequency,abs(H56)) ; 
title('H56') ;
xlim( [0 500] );
   
figure(1)
subplot(3,1,1);
  r12 = movmean(r12,1300);
plot(frequency,((r12))); xlim([100 500]) ;ylim([0 1]) ; hold on
%     plot(Sheet1_A,Sheet1_B,'LineWidth',2.5) ; xlim([100 500]) ;ylim([0 1]) ;hold off
ylabel('反射系数');
title(save_name);
grid on
hold off
subplot(3,1,2);
    t13 = movmean(t13,1300);
plot(frequency,(t13)); xlim([100 500]) ;ylim([0 1]) ;
ylabel('透射系数-mic-13');
grid on
hold on
%     plot(Sheet1_A,Sheet1_C,'LineWidth',2.5) ; xlim([100 500]) ;ylim([0 1]) ;
hold off
subplot(3,1,3);
  t15 = movmean(t15,1300);
plot(frequency,(t15)); xlim([100 500]) ;ylim([0 1]) ;
ylabel('透射系数-mic-15');
grid on
hold on
%       plot(Sheet1_A,Sheet1_D,'LineWidth',2.5) ; xlim([100 500]) ; ylim([0 1]) ;
%
% print('1','-djpeg','-r500')
hold off

% figure(2)
% plot(frequency,abs(rH));
%   xlim( [0 500]); ylim( [0 1]) ;

figure(2)
     plot(frequency,((r12))); xlim([100 500]) ;ylim([0 1]) ; 
     title('R-Mic-12');
 hold on
%  plot(Sheet1_A,Sheet1_B,'LineWidth',1.5) ; xlim([100 500]) ;ylim([0 1]) ; hold off
% print('3R-Mic-12','-djpeg','-r500')
hold off

 
 figure(3)
     plot(frequency,((r34))); xlim([100 500]) ;ylim([0 1]) ; 
     title('R-Mic-34');
 print('4R-Mic_34','-djpeg','-r500')

 figure(4)
     plot(frequency,((r56))); xlim([100 500]) ;ylim([0 1]) ; 
     title('R-Mic-56');
%  print('5R-Mic-56','-djpeg','-r500')
    

z_1 = (1.225 * 346) .*((1+r12_raw)./(1-r12_raw)) ;
z_2 = 1.225 * 346 *((1+r34_raw)./(1-r34_raw)) ;
z_3 = 1.225 * 346 *((1+r56_raw)./(1-r56_raw)) ;

z_1_real = real(z_1);
z_1_img = imag(z_1) ;
z_2_real = real(z_2) ;
z_2_img = imag(z_2) ;
z_3_real = real(z_3) ;
z_3_img = imag(z_3) ;

z_2_mag = abs(z_2);
z_3_mag = abs(z_3);
% z_1_real = movmean(real(z_1),100) ;
% z_1_img = movmean(imag(z_1),100) ;
% z_2_real = movmean(real(z_2),100) ;
% z_2_img = movmean(imag(z_2),100) ;
% z_3_real = movmean(real(z_3),100) ;
% z_3_img = movmean(imag(z_3),100) ;

figure(5)
     plot(frequency,abs((z_1))); xlim([0 500])  ; 
     title('Z-mic12');
print('6-Z-mic12','-djpeg','-r500')

figure(6)
     plot(frequency,(abs(z_2))); xlim([0 500])  ; 
     title('Z-mic34');
print('7-Z-mic34','-djpeg','-r500')

figure(7)
     plot(frequency,(abs(z_3))); xlim([0 500]) ; 
     title('Z-mic56');
print('8-Z-mic56','-djpeg','-r500')

delta_f = 24000/(length(mic_1_time)/2) ;
f_begin =round( 1 / delta_f)+1 ; 
f_end =  round( 1500 / delta_f)+1 ;
f = f(f_begin:f_end) ; 
r12 = r12(f_begin:f_end) ; 
t13 = t13(f_begin:f_end) ; 
t15 = t15(f_begin:f_end) ; 

distFig
cc