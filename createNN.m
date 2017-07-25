function [net_1, net_2] = createNN()
    %% Creating the first neural network
    
    global ds_sf ds_target;

    % Samples by columns
    ds_sf_by_columns = ds_sf';
    ds_target_by_columns = ds_target';

    % Creating it
    trainFcn = 'trainscg';
    hiddenLayerSize = 10;
    net_1 = patternnet(hiddenLayerSize, trainFcn);

    % Training it
    net_1.trainParam.showWindow = false; % no GUI
    [net_1, training_record] = train(net_1, ds_sf_by_columns, ds_target_by_columns);

    % Testing it
    result = net_1(ds_sf_by_columns);
    errors = gsubtract(ds_target_by_columns, result);
    % performance = perform(net, target, result)
    % target_indexes = vec2ind(target);
    % result_indexes = vec2ind(result);
    % percentErrors = sum(target_indexes ~= result_indexes)/numel(target_indexes);

    % View the Network
     view(net_1)

    % Plots
     figure, plotperform(training_record)
     figure, plottrainstate(training_record)
     figure, ploterrhist(errors)
     figure, plotconfusion(ds_target_by_columns, result)
     figure, plotroc(ds_target_by_columns, result)

    %% Creating the second neural network

    global d_sf d_target;
    
    % Samples by columns
    d_sf_by_columns = d_sf';
    d_target_by_columns = d_target';

    % Creating it
    trainFcn = 'trainscg';
    hiddenLayerSize = 20;
    net_2 = patternnet(hiddenLayerSize, trainFcn);

    % Training it
    net_2.trainParam.showWindow = false; % no GUI
    [net_2, training_record] = train(net_2, d_sf_by_columns, d_target_by_columns);

    % Testing it
    result = net_2(d_sf_by_columns);
    errors = gsubtract(d_target_by_columns, result);
    % performance = perform(net, target, result)
    % target_indexes = vec2ind(target);
    % result_indexes = vec2ind(result);
    % percentErrors = sum(target_indexes ~= result_indexes)/numel(target_indexes);

    % View the Network
     view(net_2)

    % Plots
     figure, plotperform(training_record)
     figure, plottrainstate(training_record)
     figure, ploterrhist(errors)
     figure, plotconfusion(d_target_by_columns, result)
     figure, plotroc(d_target_by_columns, result)

    %% Cleaning
    clear criteriaFunctionHandler;
end