% Testing the Mamdani fuzzy classifier
% for all possible horizontal input samples

global ds_h_samples;

for i = 1:size(ds_h_samples, 1)
    ans = mfc_h(ds_h_samples(i, :));
end
clear i ans;