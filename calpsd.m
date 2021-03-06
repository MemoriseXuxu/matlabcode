function [f,psd_Amp] = calpsd(fs,sample)

%%  Demo Code  %%
% f0 = 40 ; %frequency of the sine wave
% fs = 1000 ;  
% T = 1 /fs ;
% t = 0:T:1-T; %sampling period
% y = 4*sin(2*pi*f0*t)+10*sin(2*pi*80*t); %the sine curve
% L = length(y) ;
%%  Begin  %%
sample = sample - mean(sample);
L = length(sample);
f = fs * (0:1:(L/2))/L ;
f = f';
Y = sample(1:L) ;
S = fft(Y) ;
P2 = abs(S)/(L/2) ;
P1 = P2(1:L/2+1) ;
psd_Amp = (abs(P1)).^2 ;
%%  End  %%