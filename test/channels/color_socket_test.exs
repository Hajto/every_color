defmodule EveryColor.ColorSocketTest do
  use EveryColor.ChannelCase

  alias EveryColor.DistributionChannel

  test "Joins and receives a color" do
    {:ok, reply , socket} = socket("user_id", %{some: :assign})
      |> subscribe_and_join(DistributionChannel, "colors:test")

    %{color: color, counter: counter} = reply
    assert is_number color
    assert is_number counter

    assert_broadcast "counter_bump", %{counter: ^counter}

    ref = push socket, "get", %{}
    assert_reply ref, :ok, %{color: _ }
  end
end
