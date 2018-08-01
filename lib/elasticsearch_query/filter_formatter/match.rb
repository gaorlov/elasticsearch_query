module ElasticsearchQuery
  module FilterFormatter
    class Match < Base
      def to_hash
        { match: { @name => @value } }
      end
    end
  end
end