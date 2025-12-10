clear; clc; close all;
gsp_start()
addpath('draw');

Data = load('Data.mat');
X = Data.data';
Z = gsp_distanz(X).^2;

%% 1 & 2
[W1] = gsp_learn_graph_l2_degrees(Z, 5);
W1 = adjust(W1, 0.1);
G1 = gsp_graph(W1);
draw_animal_graph(G1.L, Data.names)
figure;
imagesc(W1)

[W2] = gsp_learn_graph_log_degrees(Z, 5, 5);
W2 = adjust(W2, 0.1);
G2 = gsp_graph(W2);
draw_animal_graph(G2.L, Data.names)
figure;
imagesc(W2)

%% 3.a
close all;
for a=5:2:13
    [W1] = gsp_learn_graph_l2_degrees(Z, a);
    W1 = adjust(W1, 0.1);
    G1 = gsp_graph(W1);
    draw_animal_graph(G1.L, Data.names)
    figure;
    imagesc(W1)
    title(a)
end

%% 3.b
close all;
for b=5:5:25
    [W2] = gsp_learn_graph_log_degrees(Z, a, b);
    W2 = adjust(W2, 0.1);
    G2 = gsp_graph(W2);
    draw_animal_graph(G2.L, Data.names)
    figure;
    imagesc(W2)
    title(b)
end

%% 5
clc; close all;
addpath(genpath('Graph_Learning-master'));

[L] = estimate_cgl(cov(X), ones(33), 0.08);
W = diag(diag(L)) - L;
W = adjust(W, 0.1);
G = gsp_graph(W);
draw_animal_graph(G.L, Data.names)
figure;
imagesc(W2)

%% functions
function Y = adjust(X, t)
    m = max(X,[],"all");
    Y = X / m;
    Y(Y<t) = 0;
end