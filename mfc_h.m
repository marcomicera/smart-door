% Mamdani fuzzy classifier for horizontal samples

function result = mfc_h(input)
    %% result variable structure
    % [0 0]: static
    % [0 1]: in
    % [1 0]: out
    % [1 1]: pass

    %% Checking input dimension
    if size(input, 1) ~= 1
        error('Wrong input row size');
    elseif size(input, 2) ~= 30
        error('Wrong input column size');    
    end

    %% Loading the mfc
    global ds_h_extracted_features;
    mfc_1 = readfis('mfc_h_1');
    
    %% Input computation
    input_1 = [std(input) mean(input)]; % feature extraction
    ds_h_output = evalfis(input_1, mfc_1);
    ds_h_output = ds_h_output(1);

    if ds_h_output >= 0 && ds_h_output < 0.5 % dynamic
        mfc_2 = readfis('mfc_h_2');
        
        global d_h_sf_indexes;
        input_2_fs = input(:, find(d_h_sf_indexes)); % feature selection
        input_2 = [std(input_2_fs) mean(input_2_fs)]; % feature extraction

        d_h_output = evalfis(input_2, mfc_2);
        d_h_output = d_h_output(1);

        if d_h_output >= 0 && d_h_output < 0.3333 % in
            result = [0; 1];
            disp('The given input represents an entering (in) action.');
        elseif d_h_output >= 0.3333 && d_h_output < 0.6666 % out
            result = [1; 0];
            disp('The given input represents an exiting (out) action.');
        elseif d_h_output >= 0.666 && d_h_output < 1 % pass
            result = [1; 1];
            disp('The given input represents a passing action.');
        else
            result = [-1, -1];
            disp('The given input does not represent nothing.');
        end
    elseif ds_h_output >= 0.5 && ds_h_output < 1
        result = [0; 0];
        disp('The given input represents a static action.');
    else
        result = [-1, -1];
        disp('The given input does not represent nothing.');
    end
end