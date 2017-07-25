%% Creating a Self-Organizing Map for dynamic discrimination
global som_net_v som_v_clusters;
som_net_v = selforgmap([10 10]);
    
%% Choosing Plot Functions
som_net_v.plotFcns = {
    'plotsomtop','plotsomnc','plotsomnd', ...
    'plotsomplanes', 'plotsomhits', 'plotsompos'
};

%% Training
global v_samples;
[som_net_v, ~] = train(som_net_v, v_samples');

%% Clustering

% SOM weights
som_v_weights = som_net_v.IW{1, 1};

% 'ward': Inner squared distance (minimum variance algorithm), 
% appropriate for Euclidean distances only
som_v_linkages = linkage(som_v_weights, 'ward'); 

% som_v_dendrogram = dendrogram(som_v_linkages, 0);

% Clusters creation
som_v_clusters = cluster(som_v_linkages, 'maxclust', 3);

%% som_net_v plots
% figure, plotsomtop(som_net_v)
% figure, plotsomnc(som_net_v)
% figure, plotsomnd(som_net_v)
% figure, plotsomplanes(som_net_v)
% figure, plotsomhits(som_net_v, v_samples')
% figure, plotsompos(som_net_v, v_samples')