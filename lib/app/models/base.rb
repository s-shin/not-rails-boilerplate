module App
  module Models
    class Base < Hashie::Dash
      extend DB::Table

      def self.column(name, *argv, **opts)
        property(name, *argv, **opts)
      end
    end
  end
end
