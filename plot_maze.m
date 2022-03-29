function plot_maze(maze, scale, paths, colors)
    maze = repelem(maze, scale, scale);

    [height, width] = size(maze);
    
    maze_rgb = -165 * (maze - 1) + 90;
    
    cells = zeros(height, width, 3);
    cells(:, :, 1) = maze_rgb;
    cells(:, :, 2) = maze_rgb;
    cells(:, :, 3) = maze_rgb;
    
    for i = 1 : length(paths)
        path = paths{i};
        color = colors{i};
        for step = path
            row = step(1);
            col = step(2);
            cells(row, col, 1) = color(1);
            cells(row, col, 2) = color(2);
            cells(row, col, 3) = color(3);
        end
    end
    
    imagesc(rescale(cells))
    set(gca, 'XTick', [], 'YTick', [])
    set(gca, 'XColor', 'none', 'YColor', 'none')
    pbaspect([1 1 1])
end
