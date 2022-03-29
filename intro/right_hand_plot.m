scale = 4;

right_hand_path = right_hand_solver(maze, scale);

paths = {right_hand_path};
colors = {red};

plot_maze(maze, scale, paths, colors)
