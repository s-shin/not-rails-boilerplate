module App
  class Context
    class RackMiddleware
      include ActiveSupport::Callbacks

      def initialize(app)
        @app = app
      end

      def call(env)
        Context.instance.run_callbacks :request do
          @app.call(env)
        end
      end
    end

    include ActiveSupport::Callbacks
    define_callbacks :request

    class << self
      def instance(new_instance = nil)
        @context = new_instance if new_instance
        @context ||= new
      end
    end

    def project_root
      @project_root ||= File.expand_path('../..', __dir__)
    end

    def env
      @env ||= ENV['RACK_ENV']
    end

    # @param name [Symbol, String] Database target name.
    def db(name)
      @db ||= {}
      target = "#{env}_#{name}".to_sym
      @db[target] ||= Sequel.connect(config(:database)[target])
    end

    set_callback :request, :after do
      if @db
        @db.each(&:disconnect)
        @db = nil
      end
    end

    # @param name [Symbol, String] Config name w/o extension.
    def config(name)
      @config ||= {}
      @config[name.to_sym] = Hashie::Mash.load(Pathname(project_root) + "config/#{name}.yml")
    end

    # @return [Logger]
    def logger
      Logger.new(STDOUT)
    end
  end
end
