scale = 3;

random_path = random_solver(maze, scale);

paths = {random_path};
colors = {red};

plot_maze(maze, scale, paths, colors)
