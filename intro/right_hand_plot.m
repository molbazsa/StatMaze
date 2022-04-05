scale = 3;

right_hand_path = right_hand_solver(maze, scale);

paths = {right_hand_path};
colors = {blue};

plot_maze(maze, scale, paths, colors)
