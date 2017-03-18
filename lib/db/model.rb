module DB
  class Model
    class << self
      attr_accessor :table_name, :column_names, :struct

      def table_name
        @table_name ||= name.split('::').last.tableize.to_sym
      end

      def struct
        @struct ||= Struct.new(*column_names)
      end
    end

    extend Forwardable

    attr_reader :data

    def initialize(data)
      data = data.fetch_values(*self.class.column_names) { nil } if data.is_a? Hash
      @data = self.class.struct.new(*data)
    end

    def method_missing(name, *args)
      return @data.send(name, *args) if @data.respond_to?(name)
      super
    end

    def respond_to_missing?(name, all)
      @data.respond_to?(name, all)
    end

    def ==(other)
      @data == other.data
    end

    alias eql? ==
  end
end
