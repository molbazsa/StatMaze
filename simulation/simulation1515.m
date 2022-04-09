SIZES = [
    [15 15]
]';
N_RUNS = 10;
REPETITION = 10;

SHOULD_LOG = true;

for size = SIZES
    height = size(1);
    width = size(2);
    
    stats_optimal = zeros(1, N_RUNS);
    stats_right = zeros(1, N_RUNS);
    stats_random = zeros(REPETITION, N_RUNS);
    
    max_random = zeros(1, N_RUNS);
    risk = zeros(1, N_RUNS);
    
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
        risk(i) = max_random(i) / l_right;
        
        beats_right(i) = sum(l_random < l_right);
        is_optimal(i) = sum(l_random == l_optimal);
    end
    
    fprintf('\nMéret: %dx%d\n', height, width);
    fprintf('======\n\n');
    
    disp('Optimális:');
    disp(stats_optimal);
    disp('Jobb kéz:');
    disp(stats_right);
    disp('Random:');
    disp(stats_random);
    
    disp('Max random:');
    disp(max_random);
    disp('Kockázat:');
    disp(risk);
    
    disp('Jobb, mint a jobb kéz:');
    disp(beats_right);
    disp('A random útvonal optimális:');
    disp(is_optimal);
end
