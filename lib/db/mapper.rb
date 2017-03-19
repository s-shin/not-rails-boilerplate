module DB
  class Mapper
    attr_reader :db

    def initialize(db)
      @db = db
    end

    def self.use(db)
      self.new(db)
    end

    def select(table_class, &block)
      ctx = Context.new(db, table_class)
      ctx.instance_eval(&block) if block
      ctx
    end

    def insert(table_instance)
      @db[table_instance.class.table_name].insert(table_instance)
    end

    class Context
      def initialize(db, table_class)
        @db = db
        @ds = db[table_class.table_name].select(*table_class.column_names)
        @table_class = table_class
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
        @table_class.new(@ds.first)
      end

      def all
        @ds.all.map { |a| @table_class.new(a) }
      end
    end
  end
end
