module Mancala
  abstract class Activity(T)
    @controller : Controller(T)

    def initialize(@controller : Controller(T))
    end

    def on_start
    end

    def on_update(dt : SF::Time) : Bool
      false
    end

    def on_event(event : SF::Event) : Bool
      false
    end

    def on_render(window : SF::RenderTexture)
    end

    def on_resume
    end

    def on_delete
    end

    protected def stack_push(id : Symbol)
      @controller.push(id)
    end

    protected def stack_pop
      @controller.pop
    end

    protected def stack_clear
      @controller.clear
    end

    protected def context : T
      @controller.context
    end
  end
end
