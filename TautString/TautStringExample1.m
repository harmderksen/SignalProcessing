load bostemp
% load example
[ts,x_node,y_node,s]=TautString(tempC+3,tempC-3);
% Apply TautString
% Produces signal that lies between tempC+3 and tempC-3
days = (1:31*24)/24;
plot(days, tempC+3,'blue');
hold on;
plot(days, tempC-3,'blue');
plot(days,ts,'red');
axis tight;
ylabel('Temp (\circC)');
xlabel('Time elapsed from Jan 1, 2011 (days)');
title('Logan Airport Dry Bulb Temperature (source: NOAA)');
% plot tempC+3,tempC-3 and the Taut String
u=(s==1);
scatter(days(x_node(u)),y_node(u),'green');
% mark points where graph bends up by green
u=(s==-1);
scatter(days(x_node(u)),y_node(u),'yellow');
% mark points where graph bends up by yellow
hold off;
