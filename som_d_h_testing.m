% Testing the SOM for all possible dynamic horizontal input samples

global d_h_samples;

som_d_h_creation;
for i = 1:size(d_h_samples, 1)
    ans = som_d_h(d_h_samples(i, :));
end
clear i ans;