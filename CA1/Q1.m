clc; clear; close all;
gsp_start

%% ----- Graph Creation -----
W = zeros(4);
W(1, :) = [0 0.7 1.1 2.3];
W = W + W';
G1 = gsp_graph(W);

W = [0 1.6 2.4; 1.6 0 0.8; 2.4 0.8 0];
G2 = gsp_graph(W);

%% ----- Plot G1 and G2 -----
figure;
subplot(1,2,1)
G1.coords = gsp_compute_coordinates(G1, 2);
gsp_plot_graph(G1);
title('Graph G1')
xlabel('X-axis')
ylabel('Y-axis')

subplot(1,2,2)
G2.coords = gsp_compute_coordinates(G2, 2);
gsp_plot_graph(G2);
title('Graph G2')
xlabel('X-axis')
ylabel('Y-axis')

%% ----- Graph Products -----
figure;
subplot(1,2,1)
param.rule = 'kronecker';
Gt = gsp_graph_product(G1, G2, param);
Gt.coords = gsp_compute_coordinates(Gt);
gsp_plot_graph(Gt, param);
title('Kronecker Product Graph G_t')
xlabel('X-axis')
ylabel('Y-axis')

subplot(1,2,2)
param.rule = 'cartesian';
Gs = gsp_graph_product(G1, G2, param);
Gs.coords = gsp_compute_coordinates(Gs);
param.cp = [100 10 20];
gsp_plot_graph(Gs, param);
title('Cartesian Product Graph G_s')
xlabel('X-axis')
ylabel('Y-axis')

%% ----- Signal on Graph -----
figure;
H = Gs;
sig = 20*rand(12, 1)-10;
gsp_plot_signal(H, sig, param)
title('Random Signal on Cartesian Product Graph')
xlabel('Node Index')
ylabel('Signal Value')

%% ----- Laplacian and Eigenvalues -----
L = gsp_laplacian(H.W);
[V, u] = eig(L);

figure;
stem(1:12, diag(u), 'filled')
title('Eigenvalues of Laplacian')
xlabel('Eigenvalue Index')
ylabel('Eigenvalue Magnitude')

%% ----- Eigenvectors -----
figure;
subplot(2,2,1)
gsp_plot_signal(H, V(:, 1), param)
title('1st Eigenvector')
xlabel('Node Index')
ylabel('Value')

subplot(2,2,2)
gsp_plot_signal(H, V(:, 2), param)
title('2nd Eigenvector')
xlabel('Node Index')
ylabel('Value')

subplot(2,2,3)
gsp_plot_signal(H, V(:, end-1), param)
title('2nd to Last Eigenvector')
xlabel('Node Index')
ylabel('Value')

subplot(2,2,4)
gsp_plot_signal(H, V(:, end), param)
title('Last Eigenvector')
xlabel('Node Index')
ylabel('Value')
