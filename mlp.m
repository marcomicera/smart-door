% Multi-layer perceptron

function result = mlp(input)
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
    
    %% Constructing the neural network
    [net_1, net_2] = createNN();
    
    %% Input computation
    global ds_sf_indexes;
    result_1 = net_1(input(:, find(ds_sf_indexes)).'); 
    result_1 = round(result_1);
    
    if isequal(result_1, [0; 1]) % static input
        result = [0; 0];
        disp('The given input represents a static action.');
    elseif isequal(result_1, [1; 0]) % dinamic input
        global d_sf_indexes;
        result_2 = net_2(input(:, find(d_sf_indexes)).');
        result_2 = round(result_2);
        if isequal(result_2, [1; 0; 0]) % in
            result = [0; 1];
            disp('The given input represents an entering (in) action.');
        elseif isequal(result_2, [0; 1; 0]) % out
            result = [1; 0];
            disp('The given input represents an exiting (out) action.');
        elseif isequal(result_2, [0; 0; 1]) % pass
            result = [1; 1];
            disp('The given input represents a passing action.');
        else
            result = [-1, -1];
            disp('The given input does not represent nothing.');
        end
    else
        result = [-1, -1];
        disp('The given input does not represent nothing.');
    end
    
    %% Cleaning
    clear result_1 result_2;
end