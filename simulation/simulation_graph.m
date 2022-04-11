STEP = 0.01;

MARKER_SIZE = 30;
LINE_WIDTH = 2;

figure;
hold on;
ylim([0 Inf]);

plot(1 : N_RUNS, stats_optimal, '.', 'MarkerSize', MARKER_SIZE, ...
    'MarkerFaceColor', GREEN / 255, 'MarkerEdgeColor', GREEN / 255);
plot(1 : N_RUNS, stats_right, '.', 'MarkerSize', MARKER_SIZE, ...
    'MarkerFaceColor', BLUE / 255, 'MarkerEdgeColor', BLUE / 255);
plot(1 : N_RUNS, mean(stats_random), '.', 'MarkerSize', MARKER_SIZE, ...
    'MarkerFaceColor', RED / 255, 'MarkerEdgeColor', RED / 255);

mean_graph = repelem(mean(stats_optimal), 1, (N_RUNS - 1) / STEP + 1);
plot(1 : STEP : N_RUNS, mean_graph, 'g', 'LineWidth', LINE_WIDTH, ...
    'Color', GREEN / 255);
mean_graph = repelem(mean(stats_right), 1, (N_RUNS - 1) / STEP + 1);
plot(1 : STEP : N_RUNS, mean_graph, 'g', 'LineWidth', LINE_WIDTH, ...
    'Color', BLUE / 255);
mean_graph = repelem(mean(mean(stats_random)), 1, (N_RUNS - 1) / STEP + 1);
plot(1 : STEP : N_RUNS, mean_graph, 'g', 'LineWidth', LINE_WIDTH, ...
    'Color', RED / 255);

legend('Optimális', 'Jobb kéz', 'Random');

figure;
hold on;

b = bar(1 : N_RUNS, is_optimal);
b.FaceColor = GREEN / 255;
b.EdgeColor = GREEN / 255;
b.FaceAlpha = 0.5;

b = bar(1 : N_RUNS, beats_right);
b.FaceColor = BLUE / 255;
b.EdgeColor = BLUE / 255;
b.FaceAlpha = 0.5;

legend('Optimális', 'Rövidebb');

figure;

b = bar(1 : N_RUNS, slowdown);
b.FaceColor = RED / 255;
b.EdgeColor = RED / 255;

text(1 : N_RUNS, slowdown, num2str(round(slowdown, 1)'), ...
    'vert', 'bottom', 'horiz', 'center');

legend('Max lassítás');
