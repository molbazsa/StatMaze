function path = right_hand_solver(maze, scale)
    maze = repelem(maze, scale, scale);

    [height, width] = size(maze);
    
    path = zeros(2, 2 * height * width);

    row = 1;
    col = scale + 1;
    heading = side.BOTTOM;
    step = 1;
    path(:, step) = [row col];
    
    while ~at_exit(maze, scale, row, col)
        [row, col, heading] = next_step(maze, row, col, heading);
        step = step + 1;
        path(:, step) = [row col];
    end
    
    path(:, step + 1 : end) = [];
end

function exit = at_exit(maze, scale, row, col)
    [height, width] = size(maze);

    exit = ~(row == 1 && col == scale + 1) && ...
        (row == 1 || row == height || col == 1 || col == width);     
end

function free = is_free(maze, row, col, direction)
    switch direction
        case side.TOP
            free = maze(row - 1, col) == 0;
        case side.LEFT
            free = maze(row, col - 1) == 0;
        case side.BOTTOM
            free = maze(row + 1, col) == 0;
        case side.RIGHT
            free = maze(row, col + 1) == 0;
    end
end

function [row, col] = cell_next_to(row, col, direction)
    switch direction
        case side.TOP
            row = row - 1;
        case side.LEFT
            col = col - 1;
        case side.BOTTOM
            row = row + 1;
        case side.RIGHT
            col = col + 1;
    end
end

function [row, col, heading] = next_step(maze, row, col, heading)
    target = [
        side.RIGHT
        side.TOP
        side.LEFT
        side.BOTTOM
        side.RIGHT
        side.TOP
        side.LEFT
    ]';

    for direction = target(uint8(heading) : end)
        if is_free(maze, row, col, direction)
            break
        end
    end
    
    [row, col] = cell_next_to(row, col, direction);
    heading = direction;
end
