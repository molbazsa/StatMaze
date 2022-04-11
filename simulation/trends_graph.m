STEP = 0.01;

MARKER_SIZE = 30;
LINE_WIDTH = 2;
TREND_WIDTH = 1;

figure;
hold on;
ylim([0 Inf]);

plot(SIZES(1, :), slowdown_trend, 'g', 'LineWidth', LINE_WIDTH, ...
    'Color', RED / 255);

f = fit(SIZES(1, :)', slowdown_trend', 'poly1');
p = plot(f);
set(p, 'LineWidth', TREND_WIDTH);
set(p, 'Color', RED / 255);

legend('Max lassítás');

figure;
hold on;
ylim([0 Inf]);

plot(SIZES(1, :), beats_right_trend, 'g', 'LineWidth', LINE_WIDTH, ...
    'Color', BLUE / 255);
plot(SIZES(1, :), is_optimal_trend, 'g', 'LineWidth', LINE_WIDTH, ...
    'Color', GREEN / 255);

f = fit(SIZES(1, :)', beats_right_trend', 'poly1');
p = plot(f);
set(p, 'LineWidth', TREND_WIDTH);
set(p, 'Color', BLUE / 255);
f = fit(SIZES(1, :)', is_optimal_trend', 'poly1');
p = plot(f);
set(p, 'LineWidth', TREND_WIDTH);
set(p, 'Color', GREEN / 255);

legend('Rövidebb', 'Optimális');
