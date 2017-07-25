% Testing the SOM for all possible dynamic vertical input samples

global v_samples;

som_v_creation;
for i = 1:size(v_samples, 1)
    ans = som_v(v_samples(i, :));
end
clear i ans;