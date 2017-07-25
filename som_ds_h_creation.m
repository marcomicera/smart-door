%% Creating a Self-Organizing Map for dynamic/static discrimination
global som_net_1 som_1_clusters;
som_net_1 = selforgmap([10 10]);

%% Choosing Plot Functions
som_net_1.plotFcns = {
    'plotsomtop','plotsomnc','plotsomnd', ...
    'plotsomplanes', 'plotsomhits', 'plotsompos'
};

%% Training
global ds_h_samples;
[som_net_1, ~] = train(som_net_1, ds_h_samples');

%% Clustering

% SOM weights
som_1_weights = som_net_1.IW{1, 1};

% 'ward': Inner squared distance (minimum variance algorithm), 
% appropriate for Euclidean distances only
som_1_linkages = linkage(som_1_weights, 'ward'); 

% som_dendrogram = dendrogram(som_1_linkages, 0);

% Clusters creation
som_1_clusters = cluster(som_1_linkages, 'maxclust', 2);

%% som_net_1 plots
% figure, plotsomtop(som_net_1)
% figure, plotsomnc(som_net_1)
% figure, plotsomnd(som_net_1)
% figure, plotsomplanes(som_net_1)
% figure, plotsomhits(som_net_1, ds_h_samples')
% figure, plotsompos(som_net_1, ds_h_samples')