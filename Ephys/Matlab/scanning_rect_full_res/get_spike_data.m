function [spike_data, mean_spike] = get_spike_data(rawtrace)
    %rawtrace is an array of size m X n, where m is number of samples and n
    %is the length of samples
    spike_data = zeros(size(rawtrace));
    mean_spike = zeros(size(rawtrace,1), 100);
    for i=1:size(rawtrace, 1)
        [pks, locs, width, prominence] = findpeaks(rawtrace(i, :),1:size(rawtrace(i, :), 1), ...
            'MinPeakProminence',0.05, 'MinPeakHeight', -0.3, 'MaxPeakWidth', 50);
        
        spike_data(locs) = 1;
    
        all_spikes = zeros(size(pks, 2),100);
        for j=1:size(pks, 2)
            all_spikes(j, :) = rawtrace(i, locs(j)-49:locs(j)+50);
        end
        mean_spike(i, :) = mean(all_spikes, 1);
    %     plot(mean(all_spikes, 1));
    end
end
