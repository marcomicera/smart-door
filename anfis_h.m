% ANFIS classifier for horizontal samples

function result = anfis_h(input)
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
    anfis_1 = readfis('anfis_h_1');
    
    %% Input computation
    global ds_h_sf_indexes;
    input_ds = input(:, find(ds_h_sf_indexes)); % feature selection
    ds_h_output = evalfis(input_ds, anfis_1);
    ds_h_output = round(ds_h_output);
    
    if ds_h_output == 0 % dynamic
        anfis_2 = readfis('anfis_h_2');
        
        global d_h_sf_indexes;
        input_d = input(:, find(d_h_sf_indexes));
        d_h_output = evalfis(input_d, anfis_2);
        d_h_output = round(d_h_output);
        
        if d_h_output == 0 % in
            result = [0; 1];
            disp('The given input represents an entering (in) action.');
        elseif d_h_output == 1 % out
            result = [1; 0];
            disp('The given input represents an exiting (out) action.');
        elseif d_h_output == 2 % pass
            result = [1; 1];
            disp('The given input represents a passing action.');
        else
            result = [-1, -1];
            disp('The given input does not represent nothing.'); 
        end
    elseif ds_h_output == 1 % static
        result = [0; 0];
        disp('The given input represents a static action.');
    else
        result = [-1, -1];
        disp('The given input does not represent nothing.');
    end
end