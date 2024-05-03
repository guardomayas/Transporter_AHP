%function R = TransporterCurrent_Plotter(R, ax)
trace = R.example_traces;    
stim_end_idx= R.stim_end_idx{1};
vrest= R.vrest_example;
sample_rate = R.sample_rate;
differences = R.example_diff;
currents = R.inj_current;
spike_count = R.example_spike_count;

%% Plot with subplot
for s=1%:size(trace,1)
    x = (0:length(trace)-1) ./ sample_rate; %Transform indices to actual time
    segment_length = length(trace(stim_end_idx:end));
    vrest_line = vrest(s) * ones(1,segment_length);
    
    figure;
    subplot(2, 1, 1);  % Main plot
    hold on;
    h_trace = plot(x, trace(s,:));
    %t = epochs_in_dataset(s).spike_indices;
    %t= epochs_in_dataset(ind(i)).spike_indices;
    t = R.example_sp(s,:);
    plot(x(t), trace(s,t), 'ro');
    
    x_fill = x(stim_end_idx:end);
    y_fill =  vrest_line + differences; % corresponding y-values
    vrest_line = repmat(vrest, 1, length(y_fill));
    h_fill = fill([x_fill, fliplr(x_fill)], [y_fill, fliplr(vrest_line)], 'b', 'FaceAlpha', 0.3);
    xlabel('Time (s)');
    ylabel('Voltage (mV)');
    title(['Long pulse with AHP area, Current:' num2str(currents{1}(s), '%.2f pA') ', Spikes: ' num2str(spike_count{1}(s))]);
    v_line  = xline(stim_end_time, 'g-', 'LineWidth', 2);    
    % Add horizontal line at vrest_vector(s)
    h_line = yline(vrest, 'r-', 'LineWidth', 2);
    %legend([h_trace, h_fill, vrest_line, h_line], {'Trace', ['Shaded AHP Area: ' num2str(ahp_area, '%.2f')], 'Stimulus End', ['Resting Voltage: ' num2str(h_line_value, '%.2f') ' mV']}, 'Location', 'best')
    legend([h_trace, h_fill, v_line, h_line], {'Trace', ['Shaded AHP Area: ' num2str(ahp_area, '%.2f')], 'Stimulus End', ['Resting Voltage: ' num2str(vrest, '%.2f') ' mV']},'Location', 'best')
    
    hold off;
    
    subplot(2, 1, 2);  % Subplot for zoomed-in view
    plot(x, trace(s,:));  % Repeat plotting of the trace
    hold on;
    fill([x_fill, fliplr(x_fill)], [y_fill, fliplr(vrest_line)], 'b', 'FaceAlpha', 0.3);  % Repeat shading
    
    % Set x and y limits to zoom in on the shaded area
    xlim([min(x_fill), max(x_fill)]);
    ylim([min(y_fill) - 5, max(y_fill) + 5]);  % Adjust padding as needed
    
    xlabel('Time (s)');
    ylabel('Voltage (mV)');
    title('Zoomed View of AHP');
    hold off;
end



%% Calculte AHP/spike ratio
    %for s = ?
        %ahp_amplitude... from other file
        % ahp_area = mean(trace(postTime:end)) - vrest; % scaled version of area
        ahp_area = sum(trace(postTime:end) - vrest)/sample_rate; % true area
        %

        % How to compare across animals
        % Idea: look at a scatter plot: AHP_area/amplitude(y) vs. spike_count(x)    
                % each trial is a scatter point
                % assign each cell a different marker, maybe
                % if a clear pattern emerges, you can stratify by cell type
                % for example
                %   if it's a straight line relationship, get the slope and
                %   y-intercept
                %   then, scatter each cell in slope (y) vs. intercept (x)
                %   and label by cell type
        %
        %
 %end
%end