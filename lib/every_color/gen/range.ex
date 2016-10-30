defmodule EveryColor.Range do

  @caching_step 10

  def cache(first..last) do
    cond do
      last - first > @caching_step ->
        new_start = first + @caching_step
        new_range = new_start..last
        { first..(new_start - 1) |> Enum.to_list, new_range }
      true -> { first..last |> Enum.to_list , nil }
    end
  end

  def caching_step, do: @caching_step

end
