SCALE = 3;

random_path = random_solver(maze, SCALE);

paths = {random_path};
colors = {RED};

plot_maze(maze, SCALE, paths, colors)
