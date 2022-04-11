SIZES = [
    [5 5]
    [6 6]
    [7 7]
    [8 8]
    [9 9]
    [10 10]
]';
N_RUNS = 10;
REPETITION = 10;

SHOULD_LOG = true;

slowdown_trend = zeros(1, length(SIZES));
beats_right_trend = zeros(1, length(SIZES));
is_optimal_trend = zeros(1, length(SIZES));

for j = 1 : length(SIZES)
    size = SIZES(:, j);
    
    height = size(1);
    width = size(2);
    
    stats_optimal = zeros(1, N_RUNS);
    stats_right = zeros(1, N_RUNS);
    stats_random = zeros(REPETITION, N_RUNS);
    
    max_random = zeros(1, N_RUNS);
    slowdown = zeros(1, N_RUNS);
    
    beats_right = zeros(1, N_RUNS);
    is_optimal = zeros(1, N_RUNS);
    
    fprintf('\nMéret: %dx%d\n', height, width);
    fprintf('======\n');
    
    for i = 1 : N_RUNS
        if SHOULD_LOG
            fprintf('[LOG] Run %d\n', i);
        end
        
        [l_optimal, l_right, l_random] = ...
            simulate_maze(height, width, REPETITION, SHOULD_LOG);
        stats_optimal(i) = l_optimal;
        stats_right(i) = l_right;
        stats_random(:, i) = l_random';
        
        max_random(i) = max(l_random);
        slowdown(i) = max_random(i) / l_right;
        
        beats_right(i) = sum(l_random < l_right);
        is_optimal(i) = sum(l_random == l_optimal);
    end
    
    slowdown_trend(j) = mean(slowdown);
    beats_right_trend(j) = mean(beats_right);
    is_optimal_trend(j) = mean(is_optimal);
end

trends_graph;
