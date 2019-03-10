require "./activity"

module Mancala
  class Controller(T)
    @factories = Hash(String, Proc(Controller(T), Activity(T))).new
    @stack = Array(Activity(T)).new
    @surface = SF::RenderTexture.new

    getter context : T

    def initialize(@window : SF::RenderWindow, @context = T.new)
      @surface.create @window.size.x, @window.size.y
    end

    def initialize(@window : SF::RenderWindow, virtual : SF::Vector2(Int32), @context = T.new)
      @surface.create virtual.x, virtual.y
    end

    def handle_event(event : SF::Event)
      @stack.reverse.each { |activity| break unless activity.on_event(event) }
    end

    def update(dt : SF::Time)
      @window.close if empty?

      @stack.reverse.each { |activity| break unless activity.on_update(dt) }
    end

    def render
      @surface.clear SF::Color::Black

      render(@stack.last?)

      @surface.display

      post = SF::Sprite.new(@surface.texture)

      @window.draw post
    end

    def render(activity : Activity(T))
      activity.on_render(@surface)
    end

    def render(activity : Nil)
    end

    def push(id : Symbol)
      push(id.to_s)
    end

    def push(id : String)
      activity = @factories[id].call(self)
      push(activity)
    end

    def push(activity : Activity(T))
      activity.on_start
      @stack << activity
    end

    def pop
      if activity = @stack.last?
        activity.on_delete
      end

      @stack.pop

      if activity = @stack.last?
        activity.on_resume
      end
    end

    def clear
      @stack.clear
    end

    def empty?
      @stack.empty?
    end

    def register(id : Symbol, &block : Controller(T) -> Activity(T))
      register(id.to_s, &block)
    end

    def register(id : String, &block : Controller(T) -> Activity(T))
      @factories[id] = block
    end
  end
end
