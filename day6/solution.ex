defmodule Day6 do
    def solve do
        list = read_file("input")
        IO.inspect restack(list), label: "Iterations / cycle size: "
    end

    def restack(list, map \\ Map.new, n \\ 0) when is_list(list) do
        new_map = Map.put(map, list, n)
        # If the new map is the same size as the old map, then we've been here
        # before and have found a cycle.
        if Map.size(new_map) == Map.size(map) do
            cycle_size = n - Map.get(map, list)
            {Map.size(map), cycle_size}
        else
            {max, index} = list
                |> Enum.with_index
                |> Enum.max_by(fn(x) -> elem(x, 0) end)
            # Set the cell with the current maximum to 0
            new_list = List.replace_at(list, index, 0)
            # Add 1 to each cell in turn until we've added "max" back to the
            # whole system.
            new_list = (index + 1)..(index + max)
                |> Enum.reduce(new_list, fn(x, acc) -> increment_at(acc, x) end)
            restack(new_list, new_map, n + 1)
        end
    end

    # With wrap-around, increment the value in the list at index n
    def increment_at(list, n) when is_list(list) do
        index = rem n, Enum.count(list)
        List.update_at(list, index, &(&1 + 1))
    end

    def read_file(path) when is_binary(path) do
        input = File.read! path
        input
            # Remove trailing newline
            |> String.split_at(-1) |> elem(0)
            |> String.split("\t")
            |> Enum.map(fn(x) -> String.to_integer(x) end)
    end
end

Day6.solve
