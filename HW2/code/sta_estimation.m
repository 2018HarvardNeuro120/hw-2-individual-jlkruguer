clear all

% Load DMR stimulus specrogram and spiking responses from one neuron
load dmr_experiment

% Plot spectrogram of stimulus
plot_spectrogram(stim_spectrogram, stim_time, stim_freq)

%% Generate STA
t_past = 125; % in ms
t_future = 125; % in ms
sampling_rate = mean(median(diff(stim_time)));
sta_time = (-t_past/1000):sampling_rate:(t_future/1000);
sta_freq = stim_freq;

% sta = ???
sta = zeros(38, size(sta_time,2));
sp = 0;

for spike = spikes'
    
    % Find window
    window = sta_time + spike;
    startOfWindow = window(1);
    endOfWindow = window(end);
    
    % Find indices within window
    ind = find(startOfWindow <= stim_time & stim_time <= endOfWindow);
    
    if size(ind,2) ~= 51
        ind = [ind, (ind(end) + 1)];
    end
    
    aroundWindow = stim_spectrogram(:,ind);
    sta = sta + aroundWindow;
    
end

numberOfSpikes = size(spikes,1);
sta = sta / numberOfSpikes;


% Plot results
figure(2)
plot_spectrogram(sta, sta_time, sta_freq);
xlabel('Time relative to spike (ms)')
colorbar