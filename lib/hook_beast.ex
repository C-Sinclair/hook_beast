defmodule HookBeast do
  @moduledoc """
  Want co-located hooks in your Phoenix LiveView? 

  HookBeast has your back
  """

  defmacro __using__(_opts) do
    # LETS DO IT IN A MACROOOOO
    js_path = get_path(__CALLER__.file)

    script = """
    <script type="module">
      import * as hooks from '#{js_path}';

      Object.keys(hooks).forEach(key => {
        liveSocket.addHookDynamically(key, hooks[key]);
      })
    </script>
    """

    quote bind_quoted: [script: script] do
      def render(assigns) when not is_map_key(assigns, :__hook_beast) do
        var!(assigns) = assigns |> Map.put(:__hook_beast, unquote(script))

        ~H"""
        <%= raw(@__hook_beast) %>
        <%= render(assigns) %>
        """
      end
    end
  end

  defp get_path(path) do
    folder =
      path
      |> String.split("lib/")
      |> List.last()
      |> Path.split()
      |> List.delete_at(-1)
      |> Enum.join("/")

    "/assets/lib"
    |> Path.join(folder)
    |> Path.join("hooks.js")
  end
end
