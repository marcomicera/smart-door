% Testing the multi-layer perceptron
% for all possible input samples

global ds_samples;

for i = 1:size(ds_samples, 1)
    ans = mlp(ds_samples(i, :));
end
clear i ans;