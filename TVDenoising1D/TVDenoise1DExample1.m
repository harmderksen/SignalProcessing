load bostemp
days = (1:31*24)/24;
tempC=tempC';
figure(1);
clf;
plot(days, tempC,'blue');
axis tight;
ylabel('Temp (\circC)');
xlabel('Time elapsed from Jan 1, 2011 (days)');
title('Logan Airport Dry Bulb Temperature (blue), total variation denoising (red)');
hold on; % load and plot example
f0=TVDenoise1D(tempC,-1,40,.9999);
plot(days,f0,'red');
hold off;
figure(2);
clf;
plot(days, tempC,'blue');
axis tight;
ylabel('Temp (\circC)');
xlabel('Time elapsed from Jan 1, 2011 (days)');
title('Logan Airport Dry Bulb Temperature (blue), l1 trend filtering (red)');
hold on; % load and plot example
f1=TVDenoise1D(tempC,0,1000,.75);
plot(days,f1,'red');
hold off;
figure(3);
clf;
plot(days, tempC,'blue');
axis tight;
ylabel('Temp (\circC)');
xlabel('Time elapsed from Jan 1, 2011 (days)');
title('Logan Airport Dry Bulb Temperature (blue), C1 approximation (red)');
hold on; % load and plot example
f2=TVDenoise1D(tempC,1,10000,.4);
plot(days,f2,'red');
hold off;
