function plot_maze(maze)
    [height, width] = size(maze);
    
    maze_rgb = -255 * (maze - 1);
    
    cells = zeros(height, width, 3);
    cells(:, :, 1) = maze_rgb;
    cells(:, :, 2) = maze_rgb;
    cells(:, :, 3) = maze_rgb;
    
    imagesc(cells)
    set(gca, 'XTick', [], 'YTick', [])
    set(gca, 'XColor', 'none', 'YColor', 'none')
    pbaspect([1 1 1])
end
