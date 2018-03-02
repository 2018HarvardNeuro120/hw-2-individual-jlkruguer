clear all

load exposure_stimulus_experiment.mat

stimulus_start_times = 0:1/6:(60-1/6); % In seconds

%% Auditory Neurosplasticity: Part (a)
             
% Define trial edges in order to sort spikes
nTrials = length(stimulus_start_times);
[N,edges,bin] = histcounts(spikes_single_unit, nTrials);

% Populate a trial struct with relevant spikes for each trial
trials = struct;
time_set = 1/6;
for i=1:nTrials
    trials(i).spikes = (spikes_single_unit(edges(i) < spikes_single_unit & spikes_single_unit < edges(i+1)));
    trials(i).spikes = trials(i).spikes - edges(i);
end

%% Create Raster plot of 1/6 second stimulus and neural spiking response
figure; % Create a new figure
hold on; 
% Use trial binned spike times to generate raster plot
for i=1:nTrials
    for j=1:length(trials(i).spikes)
        if length(trials(i).spikes)==0
            continue;
        else
            line([trials(i).spikes(j), trials(i).spikes(j)], [i-1 i])
        end 
    end 
end
xlabel('Time (s)'); % time is in seconds
ylabel('Stimulus Number');
xlim([0 1/6])
ylim([0 360])


