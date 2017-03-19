module DB
  module Table
    attr_accessor :table_name, :column_names

    def table_name
      @table_name ||= name.split('::').last.tableize.to_sym
    end
  end
end
