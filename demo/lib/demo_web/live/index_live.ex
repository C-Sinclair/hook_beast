defmodule DemoWeb.IndexLive do
  @moduledoc false
  use DemoWeb, :live_view
  use HookBeast

  def render(assigns) do
    ~H"""
    <h1>Demo time</h1>

    <p phx-hook="Logger" id="123">Task</p>
    <div phx-hook="ACoolThing" id="45y" phx-update="ignore"/>
    """
  end
end
