% analyzeRESP calculates respiration rate using time and frequency domain
% analyses

function [rr,rr_fft] = analyzeRESP(time,resp,plotsOn)
    % INPUTS: 
    % time: elapsed time (seconds)
    % resp: output from pressure sensor (voltage)
    % plotsOn: true for plots, false for no plots
    
    % OUTPUT:
    % rr: respiration rate (brpm) found from time domain data
    % rr_fft: respiration rate (brpm) found from frequency domain data

    % save orgiinal data
    time_raw = time;
    resp_raw = resp;

    % calculate fs
    fs = 14.7733; % FILL IN CODE HERE

    % remove offset
    resp = resp - mean(resp);

    % bandpass pass filter resp
    w1 = 0.833; % FILL IN CODE HERE
    w2 = 1.5; % FILL IN CODE HERE
    resp = bandpass(resp,[w1 w2],fs);

    % find peaks
    [pks, locs] = findpeaks(resp, time, 'MinPeakDistance', 1);
    
    % FILL IN CODE HERE (look at findpeaks documentation)

    % calcuate rr
    rr = length(pks)/((time(end) - time(1))/60); % FILL IN CODE HERE
    

    % fft
    Y = fft(resp);
    P2 = abs(Y/length(resp));
    P1 = P2(1:length(resp)/2+1);
    P1(2:end-1) = 2*P1(2:end-1);% FILL IN CODE HERE (look at fft documentation)
    f = fs*(0:(length(resp)/2))/length(resp);% FILL IN CODE HERE (look at fft documentation)

    % calcuate rrFft
    [~, i] = max(P1);
    rr_fft = f(i)*60; % FILL IN CODE HERE (hint: look at max documentation)

    if plotsOn
        figure 
        % FILL IN CODE HERE to add legends, axes labels, and * for peaks
        subplot(3,1,1) 
        plot(time_raw,resp_raw)
        xlabel('Elapsed Time(s)')
        ylabel('Voltage(V)')
        
        subplot(3,1,2)
        plot(time,resp)
        hold on
        plot(locs, pks, 'b*')
       
        xlabel('Elapsed Time(s)')
        ylabel('Filtered Voltage')
        legend({'RESP','Grace RR(brpm)'},'Location','northeast')
        hold off
       
        subplot(3,1,3)
        plot(f,P1)
        
        xlabel('Frequency(Hz)')
        ylabel('|P1(f)|')
        
       
    end
end