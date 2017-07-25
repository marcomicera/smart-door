% Dynamic/static Self-Organizing Map 

function result = som_ds_h(input)
    %% Checking input dimension
    if size(input, 1) ~= 1
        error('Wrong input row size');
    elseif size(input, 2) ~= 30
        error('Wrong input column size');    
    end

    %% Input computation
    global som_net_1 som_1_clusters;
    som_ds_h_output = som_1_clusters(find(som_net_1(input.')), 1);
    result = som_ds_h_output;
    
    if som_ds_h_output == 1
        disp('The given input belongs to the first cluster.');
    elseif som_ds_h_output == 2
        disp('The given input belongs to the second cluster.');
    else
        disp('The given input does not belong to any cluster.');
    end

    %% Cleaning
    clear training_record;
end