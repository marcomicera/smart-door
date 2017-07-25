%% Declaring global variables
global  anfis_ds_h_target anfis_ds_h_sf ds_h_samples ds_h_sf_indexes ...
        anfis_d_h_target anfis_d_h_sf d_h_samples d_h_sf_indexes ...
        anfis_v_target anfis_v_sf v_samples v_sf_indexes ...
;

%% Dynamic/static horizontal target matrix
anfis_ds_h_target = [
    0; 0; 0; 0; 0; 0; 0; 0; 0; 0; % dynamic
    0; 0; 0; 0; 0; 0; 0; 0; 0; 0;
    0; 0; 0; 0; 0; 0; 0; 0; 0; 0;
    1; 1; 1; 1; 1; 1; 1; 1; 1; 1; % static
    1; 1; 1; 1; 1; 1; 1; 1; 1; 1;
    1; 1; 1; 1; 1; 1; 1; 1; 1; 1;
    1; 1; 1; 1; 1; 1; 1; 1; 1; 1;
    1; 1; 1; 1; 1; 1; 1; 1; 1; 1;
    1; 1; 1; 1; 1; 1; 1; 1; 1; 1;
];

%% Dynamic/static horizontal selected features + targets matrix
anfis_ds_h_sf = [ds_h_samples(:, find(ds_h_sf_indexes)) anfis_ds_h_target];

%% Dynamic horizontal target matrix 
anfis_d_h_target = [
    0; 0; 0; 0; 0; 0; 0; 0; 0; 0; % in
    1; 1; 1; 1; 1; 1; 1; 1; 1; 1; % out
    2; 2; 2; 2; 2; 2; 2; 2; 2; 2; % pass
];

%% Dynamic horizontal selected features + targets matrix
anfis_d_h_sf = [d_h_samples(:, find(d_h_sf_indexes)) anfis_d_h_target];

%% Vertical target matrix
anfis_v_target = anfis_d_h_target;

%% Vertical selected features + targets matrix
anfis_v_sf = [v_samples(:, find(v_sf_indexes)) anfis_v_target];