SCALE = 3;

right_hand_path = right_hand_solver(maze, SCALE);

paths = {right_hand_path};
colors = {BLUE};

plot_maze(maze, SCALE, paths, colors)
