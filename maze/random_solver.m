function path = random_solver(maze, scale)
    [height, width] = size(maze);
    
    path = zeros(2, 2 * height * width);

    row = 1;
    col = 2;
    heading = side.BOTTOM;
    step = 1;
    path(:, step) = [row col];
    
    while ~at_exit(maze, row, col)
        [row, col, heading] = next_step(maze, row, col, heading);
        step = step + 1;
        path(:, step) = [row col];
    end
    
    path(:, step + 1 : end) = [];
    
    path = scale * path - fix(scale / 2);
    path = [[1; scale * 2 - fix(scale / 2)] path];
    
    path = continuous_path(path, scale);
end

function exit = at_exit(maze, row, col)
    [height, width] = size(maze);

    exit = ~(row == 1 && col == 2) && ...
        (row == 1 || row == height || col == 1 || col == width);     
end

function free = is_free(maze, row, col, direction)
    [height, width] = size(maze);
    
    switch direction
        case side.TOP
            if row == 1
                free = false;
            else
                free = maze(row - 1, col) == 0;
            end
        case side.LEFT
            if col == 1
                free = false;
            else
                free = maze(row, col - 1) == 0;
            end
        case side.BOTTOM
            if row == height
                free = false;
            else
                free = maze(row + 1, col) == 0;
            end
        case side.RIGHT
            if col == width
                free = false;
            else
                free = maze(row, col + 1) == 0;
            end
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
    sides = [side.TOP side.LEFT side.BOTTOM side.RIGHT];
    reverse = [side.BOTTOM side.RIGHT side.TOP side.LEFT];
    
    reverse_only_option = true;
    
    for option = sides
        if option ~= reverse(uint8(heading)) && ...
           is_free(maze, row, col, option)
            reverse_only_option = false;
            break
        end
    end
    
    if reverse_only_option
        direction = reverse(uint8(heading));
    else
        direction = randsample(sides, 1);
        
        while ~is_free(maze, row, col, direction) || ...
              direction == reverse(uint8(heading))
            direction = randsample(sides, 1);
        end
    end
    
    [row, col] = cell_next_to(row, col, direction);
    heading = direction;
end

function cpath = continuous_path(path, scale)
    cpath = zeros(2, scale * length(path));
    cpath_index = 1;

    for i = 1 : length(path) - 1
        step = path(:, i);
        next_step = path(:, i + 1);
        
        if step(1) == next_step(1)
            change_coord = 2;
        else
            change_coord = 1;
        end
        
        direction = sign(next_step(change_coord) - step(change_coord));
        
        while step(change_coord) ~= next_step(change_coord)
            cpath(:, cpath_index) = step;
            cpath_index = cpath_index + 1;
            step(change_coord) = step(change_coord) + direction;
        end
    end
    
    for i = 1 : fix(scale / 2) + 1
        cpath(:, cpath_index) = next_step;
        cpath_index = cpath_index + 1;
        next_step(change_coord) = next_step(change_coord) + direction;
    end
    
    cpath(:, cpath_index : end) = [];
end
