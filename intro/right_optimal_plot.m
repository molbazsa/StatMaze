scale = 5;

right_hand_path = right_hand_solver(maze, scale);
optimal_path = optimal_solver(maze, scale);

paths = {right_hand_path, optimal_path};
colors = {blue, green};

plot_maze(maze, scale, paths, colors)
