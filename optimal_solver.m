function path = optimal_solver(maze, scale) 
    path = right_hand_solver(maze, 1);

    i = 1;
    while i ~= length(path)
        step = path(:, i);
        repeat = i;
        for j = i + 1 : length(path)
            if path(:, j) == step
                repeat = j;
            end
        end
        path(:, i + 1 : repeat) = [];
        i = i + 1;
    end
    
    path = scale * path - fix(scale / 2);
    path = [[1; scale * 2 - fix(scale / 2)] path];
    
    path = continuous_path(path, scale);
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
