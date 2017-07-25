%% Creating a Self-Organizing Map for dynamic discrimination
global som_net_2 som_2_clusters;
som_net_2 = selforgmap([10 10]);
    
%% Choosing Plot Functions
som_net_2.plotFcns = {
    'plotsomtop','plotsomnc','plotsomnd', ...
    'plotsomplanes', 'plotsomhits', 'plotsompos'
};

%% Training
global d_h_samples;
[som_net_2, ~] = train(som_net_2, d_h_samples');

%% Clustering

% SOM weights
som_2_weights = som_net_2.IW{1, 1};

% 'ward': Inner squared distance (minimum variance algorithm), 
% appropriate for Euclidean distances only
som_2_linkages = linkage(som_2_weights, 'ward'); 

% som_2_dendrogram = dendrogram(som_2_linkages, 0);

% Clusters creation
som_2_clusters = cluster(som_2_linkages, 'maxclust', 3);

%% som_net_2 plots
% figure, plotsomtop(som_net_2)
% figure, plotsomnc(som_net_2)
% figure, plotsomnd(som_net_2)
% figure, plotsomplanes(som_net_2)
% figure, plotsomhits(som_net_2, d_h_samples')
% figure, plotsompos(som_net_2, d_h_samples')