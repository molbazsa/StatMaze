SIZES = [
    [5 5]
    [10 10]
]';
N_RUNS = 10;
REPETITION = 10;

SHOULD_LOG = false;

for size = SIZES
    height = size(1);
    width = size(2);
    
    stats_optimal = zeros(1, N_RUNS);
    stats_right = zeros(1, N_RUNS);
    stats_random = zeros(REPETITION, N_RUNS);
    
    max_random = zeros(1, N_RUNS);
    slowdown = zeros(1, N_RUNS);
    
    beats_right = zeros(1, N_RUNS);
    is_optimal = zeros(1, N_RUNS);
    
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
    
    fprintf('\nM?ret: %dx%d\n', height, width);
    fprintf('======\n\n');
    
    disp('Optim?lis:');
    disp(stats_optimal);
    disp('Jobb k?z:');
    disp(stats_right);
    disp('Random:');
    disp(stats_random);
    disp('Random ?tlag:');
    disp(mean(stats_random));
    
    disp('Max random:');
    disp(max_random);
    disp('Max lass?t?s:');
    disp(slowdown);
    
    disp('R?videbb, mint a jobb k?z:');
    disp(beats_right);
    disp('A random ?tvonal optim?lis:');
    disp(is_optimal);
    
    close all
    simulation_graph
    
    disp('Press any key');
    pause;
    close all;
end
