function normalized_array = normalizeInput(input_array, mean_values)
    %% 1) Creates a new array starting from input_array containing mean_values averages
    input_array_size = length(input_array);
    values_per_average = floor(input_array_size/mean_values);
    normalized_array = zeros(mean_values, 1);
    
    avg_start = 1;
    for current_average = 1:mean_values
        if(current_average == mean_values)
            avg_end = input_array_size - avg_start + 1;
        else
            avg_end = values_per_average;
        end
       
        normalized_array(current_average) = mean(input_array(avg_start:avg_start+avg_end-1,1));
        avg_start = avg_start + avg_end;
    end
    
    %%  2) Normalizes all values from 0 to 1
     mx = max(normalized_array);
     mn = min(normalized_array);
     for i = 1:mean_values
         normalized_array(i) = (normalized_array(i) - mn)/(mx - mn);
     end
end