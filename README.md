# Mancala

Mancala name is inspired from one of the oldest known games to still be widely played today.

It's goal is to simplify the creation of a multi-view SFML app in Crystal Lang.

## Installation

1. Add the dependency to your `shard.yml`:

   ```yaml
   dependencies:
     mancala:
       github: alex-lairan/mancala
   ```

2. Add [crsfml](https://github.com/oprypin/crsfml) to your project.

3. Run `shards install`

## Usage

First, require the shard : 

```crystal
require "mancala"
```

Then, create a context for our game : 

```crystal
struct Context
  property texture = Mancala::Resource(SF::Texture).new
end
```

Now you can create a controller :

```crystal
mode = SF::VideoMode.new(width, height)
window = SF::RenderWindow.new(mode, name, SF::Style::Fullscreen)

context = Context.new

controller = Mancala::Controller(Activities::Context).new(window, context)
```

Let's register some activities !

```crystal
class Menu < Mancala::Activity(Context)
end

class Game < Mancala::Activity(Context)
end

controller.register(:game) { |controller| Game.new(controller) }
controller.register(:menu) { |controller| Menu.new(controller) }
```

Finally, push an activity !

```crystal
controller.push(:menu)
```


This controller need to be called on your program loop.

This is an example :

```crystal
clock = SF::Clock.new

while window.open?
  dt = clock.restart

  while event = @window.poll_event
    controller.handle_event(event)
  end

  controller.update(dt)

  controller.render

  window.display
end
```

## Contributing

1. Fork it (<https://github.com/alex-lairan/mancala/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Alexandre Lairan](https://github.com/alex-lairan) - creator and maintainer
