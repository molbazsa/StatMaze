function [l_optimal, l_right, l_random] = ...
         simulate_maze(height, width, repetition, should_log)
    global RED;
    global GREEN;
    global BLUE;
    
    maze = generate_maze(height, width);
    scale = 1;
    
    optimal_path = optimal_solver(maze, scale);
    right_hand_path = right_hand_solver(maze, scale);
    
    l_optimal = length(optimal_path);
    l_right = length(right_hand_path);
    
    l_random = zeros(1, repetition);
    
    for i = 1 : repetition
        if should_log
            tic
        end
        
        random_path = random_solver(maze, scale);
        l_random(i) = length(random_path);
        
        if should_log
            fprintf('[LOG] Iteration %d: ', i);
            toc
        end
        
        if i == 1
            figure(1)
            paths = {right_hand_path, optimal_path};
            colors = {BLUE, GREEN};
            plot_maze(maze, scale, paths, colors)
        end
        
        figure(2)
        paths = {random_path};
        colors = {RED};
        plot_maze(maze, scale, paths, colors)
    end
end
