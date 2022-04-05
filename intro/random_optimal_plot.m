scale = 5;

random_path = random_solver(maze, scale);
optimal_path = optimal_solver(maze, scale);

paths = {random_path, optimal_path};
colors = {red, green};

plot_maze(maze, scale, paths, colors)
