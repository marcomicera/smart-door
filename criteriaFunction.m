function criterion = criteriaFunction(training_samples, training_targets)
    training_samples = training_samples';
    training_targets = training_targets';

    %% Create a Pattern Recognition Network
    trainFcn = 'trainscg';  % Scaled conjugate gradient backpropagation.
    hiddenLayerSize = 10;
    net = patternnet(hiddenLayerSize, trainFcn);
    
    %% Train the Network
    net.trainParam.showWindow = false; % no GUI
    [net, training_record] = train(net, training_samples, training_targets);

    %% Test the Network
    result = net(training_samples);
    errors = gsubtract(training_targets, result);
    
    %% Calculate the error
    performance = perform(net, training_targets, result);
    target_indexes = vec2ind(training_targets);
    result_indexes = vec2ind(result);
    percentErrors = sum(target_indexes ~= result_indexes)/numel(target_indexes);
    criterion = percentErrors;
end