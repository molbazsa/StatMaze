SCALE = 5;

random_path = random_solver(maze, SCALE);
optimal_path = optimal_solver(maze, SCALE);

paths = {random_path, optimal_path};
colors = {RED, GREEN};

plot_maze(maze, SCALE, paths, colors)
