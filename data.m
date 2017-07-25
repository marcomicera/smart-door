%% Declaring global variables
global  ds_samples ds_target ds_sf_indexes ds_sf ...
        d_samples d_target d_sf_indexes d_sf ...
        ds_h_samples ds_h_target ds_h_sf_indexes ds_h_sf ...
        ds_h_extracted_features ...
        ds_h_std_gaussian_parameters ...
        ds_h_mean_gaussian_parameters ...
        d_h_samples d_h_target d_h_sf_indexes d_h_sf ...
        d_h_extracted_features ...
        d_h_std_gaussian_parameters ...
        d_h_mean_gaussian_parameters ...
        v_samples v_target v_sf_indexes v_sf ...
        v_extracted_features ...
        v_std_gaussian_parameters ...
        v_mean_gaussian_parameters ...
;

%% Dynamic/static samples matrix
ds_samples = createMatrix(30); % samples by rows

%% Dynamic/static target matrix (order: dinamic, static)
ds_target = [  % samples by rows
    1 0; 1 0; 1 0; 1 0; 1 0; 1 0; 1 0; 1 0; 1 0; 1 0;
    1 0; 1 0; 1 0; 1 0; 1 0; 1 0; 1 0; 1 0; 1 0; 1 0;
    1 0; 1 0; 1 0; 1 0; 1 0; 1 0; 1 0; 1 0; 1 0; 1 0;
    1 0; 1 0; 1 0; 1 0; 1 0; 1 0; 1 0; 1 0; 1 0; 1 0;
    1 0; 1 0; 1 0; 1 0; 1 0; 1 0; 1 0; 1 0; 1 0; 1 0;
    1 0; 1 0; 1 0; 1 0; 1 0; 1 0; 1 0; 1 0; 1 0; 1 0;
    0 1; 0 1; 0 1; 0 1; 0 1; 0 1; 0 1; 0 1; 0 1; 0 1;
    0 1; 0 1; 0 1; 0 1; 0 1; 0 1; 0 1; 0 1; 0 1; 0 1;
    0 1; 0 1; 0 1; 0 1; 0 1; 0 1; 0 1; 0 1; 0 1; 0 1;
    0 1; 0 1; 0 1; 0 1; 0 1; 0 1; 0 1; 0 1; 0 1; 0 1;
    0 1; 0 1; 0 1; 0 1; 0 1; 0 1; 0 1; 0 1; 0 1; 0 1;
    0 1; 0 1; 0 1; 0 1; 0 1; 0 1; 0 1; 0 1; 0 1; 0 1;
];

%% Dynamic/static feature selection

% Criteria function handler
criteriaFunctionHandler = @criteriaFunction;

% Selected features for ds_samples
ds_sf_indexes = sequentialfs(   criteriaFunctionHandler, ...
                                ds_samples, ds_target, 'cv', 'none' ...
);

% Selected dynamic/static samples 
ds_sf = ds_samples(:, find(ds_sf_indexes));

%% Dynamic samples matrix
d_samples = ds_samples(1:60, :);

%% Dynamic target matrix (order: in, out, pass)
d_target = [ % samples by rows
    1 0 0; 1 0 0; 1 0 0; 1 0 0; 1 0 0; 1 0 0; 1 0 0; 1 0 0; 1 0 0; 1 0 0;
    0 1 0; 0 1 0; 0 1 0; 0 1 0; 0 1 0; 0 1 0; 0 1 0; 0 1 0; 0 1 0; 0 1 0;
    0 0 1; 0 0 1; 0 0 1; 0 0 1; 0 0 1; 0 0 1; 0 0 1; 0 0 1; 0 0 1; 0 0 1;
    1 0 0; 1 0 0; 1 0 0; 1 0 0; 1 0 0; 1 0 0; 1 0 0; 1 0 0; 1 0 0; 1 0 0;
    0 1 0; 0 1 0; 0 1 0; 0 1 0; 0 1 0; 0 1 0; 0 1 0; 0 1 0; 0 1 0; 0 1 0;
    0 0 1; 0 0 1; 0 0 1; 0 0 1; 0 0 1; 0 0 1; 0 0 1; 0 0 1; 0 0 1; 0 0 1;
];

%% Dynamic feature selection
  
% Selected features for d_samples
d_sf_indexes = sequentialfs(criteriaFunctionHandler, ...
                            d_samples, d_target, 'cv', 'none' ...
);

% Selected dynamic samples 
d_sf = d_samples(:, find(d_sf_indexes));

%% Dynamic/static horizontal samples matrix 
ds_h_samples = ds_samples(1:30, :); % dynamic samples
ds_h_samples = [ds_h_samples; ds_samples(61:120, :)]; % static samples

%% Dynamic/static horizontal target matrix
ds_h_target = [
    1 0; 1 0; 1 0; 1 0; 1 0; 1 0; 1 0; 1 0; 1 0; 1 0; %dynamic
    1 0; 1 0; 1 0; 1 0; 1 0; 1 0; 1 0; 1 0; 1 0; 1 0;
    1 0; 1 0; 1 0; 1 0; 1 0; 1 0; 1 0; 1 0; 1 0; 1 0;
    0 1; 0 1; 0 1; 0 1; 0 1; 0 1; 0 1; 0 1; 0 1; 0 1; %static
    0 1; 0 1; 0 1; 0 1; 0 1; 0 1; 0 1; 0 1; 0 1; 0 1;
    0 1; 0 1; 0 1; 0 1; 0 1; 0 1; 0 1; 0 1; 0 1; 0 1;
    0 1; 0 1; 0 1; 0 1; 0 1; 0 1; 0 1; 0 1; 0 1; 0 1;
    0 1; 0 1; 0 1; 0 1; 0 1; 0 1; 0 1; 0 1; 0 1; 0 1;
    0 1; 0 1; 0 1; 0 1; 0 1; 0 1; 0 1; 0 1; 0 1; 0 1;
];

%% Dynamic/static horizontal feature selection

% Selected features for ds_h_samples 
ds_h_sf_indexes = sequentialfs( criteriaFunctionHandler, ...
                                ds_h_samples, ds_h_target, 'cv', 'none' ...
);

% Horizontal selected samples
ds_h_sf = ds_h_samples(:, find(ds_h_sf_indexes));

%% Dynamic/static horizontal feature extraction
ds_h_extracted_features = zeros(size(ds_h_samples, 1), 2);
for i = 1:size(ds_h_samples, 1)
    ds_h_extracted_features(i, :) = [
        std(ds_h_samples(i, :)) ...
        mean(ds_h_samples(i, :)) ...
    ];
end
clear i;

ds_h_std_gaussian_parameters = [ % dynamic, static
    std(ds_h_extracted_features(1:30, 1)) ... % dynamic
        mean(ds_h_extracted_features(1:30, 1));
    std(ds_h_extracted_features(31:90, 1)) ... % static
        mean(ds_h_extracted_features(31:90, 1)); 
];

ds_h_mean_gaussian_parameters = [ % order by rows: dynamic, static
    std(ds_h_extracted_features(1:30, 2)) ... % dynamic
        mean(ds_h_extracted_features(1:30, 2));
    std(ds_h_extracted_features(31:90, 2)) ... % static
        mean(ds_h_extracted_features(31:90, 2));
];

%% Dynamic horizontal sample matrix
d_h_samples = ds_h_samples(1:30, :); %dynamic samples

%% Dynamic horizontal target matrix(order: in, out, pass)
d_h_target = [ % samples by rows
    1 0 0; 1 0 0; 1 0 0; 1 0 0; 1 0 0; % in
    1 0 0; 1 0 0; 1 0 0; 1 0 0; 1 0 0;
    0 1 0; 0 1 0; 0 1 0; 0 1 0; 0 1 0; % out
    0 1 0; 0 1 0; 0 1 0; 0 1 0; 0 1 0;
    0 0 1; 0 0 1; 0 0 1; 0 0 1; 0 0 1; % pass
    0 0 1; 0 0 1; 0 0 1; 0 0 1; 0 0 1;
];

%% Dynamic horizontal features selection 

% Selected features for d_h_samples 
d_h_sf_indexes = sequentialfs(  criteriaFunctionHandler, ...
                                d_h_samples, d_h_target, 'cv', 'none' ...
);

% Horizontal selected samples
d_h_sf = d_h_samples(:, find(d_h_sf_indexes));

%% Dyanmic horizontal feature extraction
d_h_extracted_features = zeros(size(d_h_sf, 1), 2);
for i = 1:size(d_h_sf, 1)
    d_h_extracted_features(i, :) = [
        std(d_h_sf(i, :)) ... % standard deviation
        mean(d_h_sf(i, :)) ... % mean value
    ];
end
clear i;

d_h_std_gaussian_parameters = [ % order by rows: in, out, pass
    std(d_h_extracted_features(1:10, 1)) ... % in
        mean(d_h_extracted_features(1:10, 1)); 
    std(d_h_extracted_features(11:20, 1)) ... % out
        mean(d_h_extracted_features(11:20, 1)); 
    std(d_h_extracted_features(21:30, 1)) ... % pass
        mean(d_h_extracted_features(21:30, 1)); 
];

d_h_mean_gaussian_parameters = [ % order by rows: in, out, pass
    std(d_h_extracted_features(1:10, 2)) ... % in
        mean(d_h_extracted_features(1:10, 2)); 
    std(d_h_extracted_features(11:20, 2)) ... % out
        mean(d_h_extracted_features(11:20, 2));  
    std(d_h_extracted_features(21:30, 2)) ... % pass
        mean(d_h_extracted_features(21:30, 2)); 
];

%% Vertical samples matrix
v_samples = ds_samples(31:60, :);

%% Vertical target matrix
v_target = d_target(31:60, :);

%% Vertical feature selection

% Selected features for v_samples
v_sf_indexes = sequentialfs(criteriaFunctionHandler, ...
                            v_samples, v_target, 'cv', 'none' ...
);

% Vertical selected samples
v_sf = v_samples(:, find(v_sf_indexes));

%% Vertical feature extraction
v_extracted_features = zeros(size(v_samples, 1), 2);
for i = 1:size(v_sf, 1)
    v_extracted_features(i, :) = [
        std(v_sf(i, :)) mean(v_sf(i, :))
    ];
end
clear i;

v_std_gaussian_parameters = [ % order by rows: in, out, pass, static
    std(v_extracted_features(1:10, 1)) ... % in
        mean(v_extracted_features(1:10, 1));
    std(v_extracted_features(11:20, 1)) ... % out
        mean(v_extracted_features(11:20, 1));
    std(v_extracted_features(21:30, 1)) ... % pass
        mean(v_extracted_features(21:30, 1));
];

v_mean_gaussian_parameters = [ % order by rows: in, out, pass, static
    std(v_extracted_features(1:10, 2)) ... % in
        mean(v_extracted_features(1:10, 2));
    std(v_extracted_features(11:20, 2)) ... % out
        mean(v_extracted_features(11:20, 2));
    std(v_extracted_features(21:30, 2)) ... % pass
        mean(v_extracted_features(21:30, 2));
];

%% Cleaning
clear criteriaFunctionHandler;