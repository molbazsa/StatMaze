function walls = generate_maze(height, width)
    maze = zeros(height, width, 3);
    
    set_id = 1;
    
    row = 1;
    [maze, set_id] = fill_row(maze, row, set_id);
    maze = join_cells(maze, row);
    maze(1, 1, cell_index.WALL_ABOVE) = false;
    
    for row = 2 : width - 1
        [maze, set_id] = fill_row(maze, row, set_id);
        maze = connect_row(maze, row);
        maze = join_cells(maze, row);
    end
    
    row = width;
    [maze, ~] = fill_row(maze, row, set_id);
    maze = connect_row(maze, row);
    maze = join_last_row(maze, row);
    
    walls = maze_walls(maze);
end

function dec = decision(probability)
    dec = rand(1) < probability;
end

function [maze, set_id] = fill_row(maze, row, set_id)
    [~, width, ~] = size(maze);
    for col = 1 : width
        maze(row, col, cell_index.SET_ID) = set_id;
        maze(row, col, cell_index.WALL_ABOVE) = true;
        maze(row, col, cell_index.WALL_LEFT) = true;
        set_id = set_id + 1;
    end
end

function maze = replace_set_id(maze, row, set_id, new_set_id)
    [~, width, ~] = size(maze);
    for col = 1 : width
        if maze(row, col, cell_index.SET_ID) == set_id
            maze(row, col, cell_index.SET_ID) = new_set_id;
        end
    end
end

function maze = join_cells(maze, row)
    [~, width, ~] = size(maze);
    for col = 2 : width
        left_set_id = maze(row, col - 1, cell_index.SET_ID);
        right_set_id = maze(row, col, cell_index.SET_ID);
        if left_set_id ~= right_set_id && decision(probability.JOIN)
            maze = replace_set_id(maze, row, right_set_id, left_set_id);
            maze(row, col, cell_index.WALL_LEFT) = false;
        end
    end
end

function maze = connect_row(maze, row)
    [~, width, ~] = size(maze);

    sets = unique(maze(row - 1, :, cell_index.SET_ID));
    
    for set_id = sets
        connected = false;
        while ~connected
            for col = 1 : width
                if maze(row - 1, col, cell_index.SET_ID) == set_id && ...
                   decision(probability.CONNECTION)
                    maze(row, col, cell_index.SET_ID) = set_id;
                    maze(row, col, cell_index.WALL_ABOVE) = false;
                    connected = true;
                end
            end
        end
    end
end

function maze = join_last_row(maze, row)
    [~, width, ~] = size(maze);
    for col = 2 : width
        left_set_id = maze(row, col - 1, cell_index.SET_ID);
        right_set_id = maze(row, col, cell_index.SET_ID);
        if left_set_id ~= right_set_id
            maze = replace_set_id(maze, row, right_set_id, left_set_id);
            maze(row, col, cell_index.WALL_LEFT) = false;
        end
    end
end

function [exit_side, row, col] = exit_point(maze)
    exit_side = randsample([side.LEFT side.RIGHT side.TOP side.BOTTOM], 1);
    
    [height, width, ~] = size(maze);
    
    switch exit_side
        case side.TOP
            row = 1;
            col = randsample(fix(width / 2) : width, 1);
        case side.RIGHT
            row = randsample(height, 1);
            col = width + 1;
        case side.BOTTOM
            row = height + 1;
            col = randsample(width, 1);
        case side.LEFT
            row = randsample(fix(height / 2) : height, 1);
            col = 1;
    end
end

function walls = maze_walls(maze)
    [height, width, ~] = size(maze);
    
    walls = true(2 * height + 1, 2 * width + 1);
    
    for row = 1 : height
        for col = 1 : width
            if ~maze(row, col, cell_index.WALL_ABOVE)
                walls(2 * row - 1, 2 * col) = false;
            end
        end
        
        for col = 1 : width
            walls(2 * row, 2 * col) = false;
            if ~maze(row, col, cell_index.WALL_LEFT)
                walls(2 * row, 2 * col - 1) = false;
            end
        end
    end
    
    [exit_side, exit_row, exit_col] = exit_point(maze);
    
    if exit_side == side.TOP || exit_side == side.BOTTOM
        walls(2 * exit_row - 1, 2 * exit_col) = false;
    elseif exit_side == side.LEFT || exit_side == side.RIGHT
        walls(2 * exit_row, 2 * exit_col - 1) = false;
    end
end
