module ElasticsearchQuery
  module FilterFormatter
    class Custom < Base
      def to_hash
        @value
      end
    end
  end
end