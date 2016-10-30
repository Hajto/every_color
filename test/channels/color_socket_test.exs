defmodule EveryColor.ColorSocketTest do
  use EveryColor.ChannelCase

  alias EveryColor.DistributionChannel

  test "Joins and receives a color" do
    {:ok, _, socket} = socket("user_id", %{some: :assign})
      |> subscribe_and_join(DistributionChannel, "colors")

    assert_push "color_generated", %{color: _ }

    ref = push socket, "get", "whatever payload"
    assert_reply ref, :ok, %{color: _ }
  end
end
