module Mancala
  class Resource(T)
    @resources = Hash(String, T).new

    def load(identifier : String, filename : String)
      @resources[identifier] = T.from_file(filename)
    end

    def [](identifier : String) : T
      @resources[identifier]
    end
  end
end
