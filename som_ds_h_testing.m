% Testing the SOM for all possible dynamic/static input samples

global ds_h_samples;

som_ds_h_creation;
for i = 1:size(ds_h_samples, 1)
    ans = som_ds_h(ds_h_samples(i, :));
end
clear i ans;