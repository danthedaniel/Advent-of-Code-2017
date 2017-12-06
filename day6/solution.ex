defmodule Day6 do
    def part1 do
        list = read_file("input")
        IO.inspect restack(list), label: "Iterations until a cycle: "
    end

    def restack(list, set \\ MapSet.new) when is_list(list) do
        new_set = MapSet.put(set, list)
        if MapSet.size(new_set) == MapSet.size(set) do
            MapSet.size(new_set)
        else
            {max, index} = list
                |> Enum.with_index
                |> Enum.max_by(fn(x) -> elem(x, 0) end)
            new_list = List.replace_at(list, index, 0)
            new_list = (index + 1)..(index + max)
                |> Enum.reduce(new_list, fn(x, acc) -> increment_at(acc, x) end)

            IO.inspect new_list

            restack(new_list, new_set)
        end
    end

    # With wrap-around, increment the value in the list at index n
    def increment_at(list, n) when is_list(list) do
        index = rem(n, Enum.count(list))
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

Day6.part1
