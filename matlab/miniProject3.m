clear 
clc
close all

% connect arduino
a = arduino();

% define variables and call pressureSensor function
sampleTime = 0;
thresh = 0;
livePlot = false;
pauseTime = 0;
[data] = pressureSensor(a,sampleTime,thresh,livePlot,pauseTime);

% save pressureSensor output table to a csv in your data folder
writetable(data,'C:\Users\username\git\wearable-bioinstrumentation\data\pressureSensorData.csv')

% plot voltage over time
figure
plot(data.time,data.voltage)

% calcuate data acqusition rate
fs = 0;

% calculate R2 using R1, Vin, and Vout
r2 = 0;

