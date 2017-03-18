module App
  module Models
    class Base < Hashie::Dash
      extend DB::Table
    end
  end
end
