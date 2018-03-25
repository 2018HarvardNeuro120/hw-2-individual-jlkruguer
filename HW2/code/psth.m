
function y = psth(spikes, startTime, endTime, binWidth)

bins = startTime:binWidth:endTime; % Define trial bins

y = hist(spikes(spikes >= startTime-binWidth/2 & spikes < bins(end) + binWidth/2 ),bins)/binWidth; % calculate histogram

end