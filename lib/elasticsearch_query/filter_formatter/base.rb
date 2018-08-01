module ElasticsearchQuery
  module FilterFormatter
    class Base
      def initialize( name, value )
        @name  = name
        @value = value
      end
    end
  end
end