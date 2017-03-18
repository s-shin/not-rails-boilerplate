module DB
  class Mapper
    attr_reader :db

    def initialize(db)
      @db = db
    end

    def self.use(db)
      self.new(db)
    end

    def select(model_class, &block)
      ctx = Context.new(db, model_class)
      ctx.instance_eval(&block) if block
      ctx
    end

    class Context
      def initialize(db, model_class)
        @db = db
        @ds = db[model_class.table_name].select(*model_class.column_names)
        @model_class = model_class
      end

      def sql
        @ds.sql
        self
      end

      def where(*args, **opts, &block)
        @ds = @ds.where(*args, **opts, &block)
        self
      end

      def first
        @model_class.new(@ds.first)
      end

      def all
        @ds.all.map { |a| @model_class.new(a) }
      end
    end
  end
end
