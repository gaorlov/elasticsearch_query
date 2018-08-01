module ElasticsearchQuery
  module FilterFormatter
    class Base
      def initialize( name, value )
        @name  = name
        @value = value
      end

      def to_hash
        raise NotImplementedError
      end
    end
  end
end