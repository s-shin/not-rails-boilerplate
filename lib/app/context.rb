module App
  class Context
    class RackMiddleware
      include ActiveSupport::Callbacks

      def initialize(app, ctx)
        @app = app
        @ctx = ctx
      end

      def call(env)
        ctx.run_callbacks :request do
          @app.call(env)
        end
      end
    end

    include ActiveSupport::Callbacks
    define_callbacks :request

    class << self
      attr_writer :instance
      def instance
        @instance ||= new
      end
    end

    # @param cls [Class]
    def inject(cls, *props, **aliased_props)
      props.each { |prop| aliased_props[prop] = prop }
      cls.class_eval do
        aliased_props.each do |ctx_prop, cls_prop|
          define_method cls_prop do
            @injected ||= {}
            @injected[ctx_prop] || Context.instance.send(ctx_prop)
          end
          define_method :"#{cls_prop}=" do |v|
            @injected ||= {}
            @injected[ctx_prop] = v
          end
        end
      end
    end

    def project_root
      @project_root ||= File.expand_path('../..', __dir__)
    end

    def env
      @env ||= ENV['RACK_ENV']
    end

    # @param name [Symbol, String] Database target name.
    # @return [Sequel::Database]
    def db(name)
      @db ||= {}
      target = "#{env}_#{name}".to_sym
      @db[target] ||= Sequel.connect(config(:database)[target])
    end

    def db_w
      db(:w)
    end

    def db_r
      db(:r)
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
