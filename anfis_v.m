% ANFIS classifier for vertical samples

function result = anfis_h(input)
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

    %% Loading the mfc
    anfis = readfis('anfis_v');
    
    %% Input computation
    global v_sf_indexes;
    input_d = input(:, find(v_sf_indexes)); % feature selection
    d_v_output = evalfis(input_d, anfis);
    d_v_output = round(d_v_output);
    
    if d_v_output == 0 % in
        result = [0; 1];
        disp('The given input represents an entering (in) action.');
    elseif d_v_output == 1 % out
        result = [1; 0];
        disp('The given input represents an exiting (out) action.');
    elseif d_v_output == 2 % pass
        result = [1; 1];
        disp('The given input represents a passing action.');
    else
        result = [-1, -1];
        disp('The given input does not represent nothing.'); 
    end
end