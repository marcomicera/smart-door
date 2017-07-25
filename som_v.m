% In/out/pass Self-Organizing Map for vertical samples

function result = som_v(input)
    %% Checking input dimension
    if size(input, 1) ~= 1
        error('Wrong input row size');
    elseif size(input, 2) ~= 30
        error('Wrong input column size');    
    end

    %% Input computation
    global som_net_v som_v_clusters;
    som_v_output = som_v_clusters(find(som_net_v(input.')), 1);
    result = som_v_output;
    
    if som_v_output == 1
        disp('The given input belongs to the first cluster.');
    elseif som_v_output == 2
        disp('The given input belongs to the second cluster.');
    elseif som_v_output == 3
        disp('The given input belongs to the third cluster.');
    else
        disp('The given input does not belong to any cluster.');
    end
end