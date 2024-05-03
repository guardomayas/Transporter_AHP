function scatter_ahp(R, color, legendLabel)
    all_spike_counts = [];
    all_ahp_areas = [];

    % Loop over each dataset
    for i = 1:length(R.spike_counts)
        % Check if the content is a cell and iterate through it if necessary
        if iscell(R.spike_counts{i})
            % Iterate through each nested cell array
            for j = 1:length(R.spike_counts{i})
                % Append data to the list
                all_spike_counts = [all_spike_counts; R.spike_counts{i}{j}(:)];  % Ensure column vector
                all_ahp_areas = [all_ahp_areas; R.ahp_areas{i}{j}(:)];  % Ensure column vector
            end
        else
            % Directly append if not nested
            all_spike_counts = [all_spike_counts; R.spike_counts{i}(:)];
            all_ahp_areas = [all_ahp_areas; R.ahp_areas{i}(:)];
        end
    end

    % Create scatter plot
    %figure;
    
    scatter(all_spike_counts, -1*all_ahp_areas, 'filled', 'MarkerFaceColor', color);
    xlabel('Spike Counts');
    ylabel('-AHP Areas');
    
    legend(legendLabel);
    grid on;
    hold on
end
 