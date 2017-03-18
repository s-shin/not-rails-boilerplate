module App
  class Context
    class << self
      # TODO: singleton
    end

    # @param name [Symbol|String] Config name w/o extension.
    def config(name)
      @config ||= {}
      @config = Hashie::Mash.load(Pathname(PROJECT_ROOT) + "config/#{name}.yml")
    end
  end
end
