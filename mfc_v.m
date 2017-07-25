% Mamdani fuzzy classifier for vertical samples

function result = mfc_v(input)
    %% result variable structure
    % [0 1]: in
    % [1 0]: out
    % [1 1]: pass

    %% Checking input dimension
    if size(input, 1) ~= 1
        error('Wrong input row size');
    elseif size(input, 2) ~= 30
        error('Wrong input column size');    
    end
    
    mfc = readfis('mfc_v');

    global v_sf_indexes;
    input_2_fs = input(:, find(v_sf_indexes)); % feature selection
    input_2 = [std(input_2_fs) mean(input_2_fs)]; % feature extraction

    v_output = evalfis(input_2, mfc);
    v_output = v_output(1);

    if v_output >= 0 && v_output < 0.3333 % in
        result = [0; 1];
        disp('The given input represents an entering (in) action.');
    elseif v_output >= 0.3333 && v_output < 0.6666 % out
        result = [1; 0];
        disp('The given input represents an exiting (out) action.');
    elseif v_output >= 0.666 && v_output < 1 % pass
        result = [1; 1];
        disp('The given input represents a passing action.');
    else
        result = [-1, -1];
        disp('The given input does not represent nothing.');
    end
end