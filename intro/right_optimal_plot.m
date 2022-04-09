SCALE = 5;

right_hand_path = right_hand_solver(maze, SCALE);
optimal_path = optimal_solver(maze, SCALE);

paths = {right_hand_path, optimal_path};
colors = {BLUE, GREEN};

plot_maze(maze, SCALE, paths, colors)
