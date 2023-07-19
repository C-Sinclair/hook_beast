# Hook Beast

![The dreaded hook beast](./hook_beast.png)

> Activating _Beast Mode_ for your Phoenix Liveview hooks

## Its ok to not hate Javascript

The Elixir community is filled with JS haters. Its a pretty clear fact at this point.

The author of this here library understands their pain. The ecosystem is a mess.

This is why Liveview is so appealing right?

This might sound controversial, but JS actually is pretty well suited to it's environment - the browser. Rich user interactions **are going to need ECMAscript**!!!

### Liveview holds JS at arms length

When you're building Liveview applications, you are encouraged to keep JS as far away from your code as possible.

Tiny sprinkles is all you dare touch!

OR you write a hook. But even hooks are kept all the way over in the `/assets` folder.

### Let them be friends

Step one for improving the Development Experience (DX <- totally incorrect acronym but sounds cool to say)? Co-locate your hooks with your live components.

Let thy components sit besideth each other!

## Installation

You're sold right?! Well lets get it installed then!

```elixir
def deps do
  [
    {:hook_beast, git: "https://github.com/C-Sinclair/hook_beast.git", tag: "0.1"}
  ]
end
```

Esbuild will then need to be told where to find your hook files

```elixir
# config/config.exs

js_files =
  Path.wildcard("lib/*_web/**/*.js")
  |> Enum.map(&Path.join("../", &1))
  |> Enum.join(" ")

config :esbuild,
  version: "0.14.29",
  default: [
    args:
      ~w(js/app.js #{js_files} --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/* --format=esm),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

```

Some Path wildcard magic and some extra flags for Esbuild are needed. The key ones being `--bundle` (can you guess what that does?) and `--format=esm` (No guesses allowed for that one, it will format the output as `esm` AKA Javascript's shiny new non shitty module system)

NB: This is pre-pre-alpha software. It doesn't even work unless you change the JS code which powers Liveview's client side. Sorry I should probably have mentioned that at the start!
