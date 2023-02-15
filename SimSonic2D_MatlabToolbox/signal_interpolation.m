function [interpolated_amplitude, interpolated_time] = signal_interpolation(amplitude, time, temporal_step_us)
    
    interpolated_time = 0:temporal_step_us:time(end);
    interpolated_amplitude = interp1(time,amplitude,interpolated_time);
    
end