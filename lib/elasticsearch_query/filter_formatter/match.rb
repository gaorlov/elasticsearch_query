module ElasticsearchQuery
  module FilterFormatter
    class Match < Base
      def to_hash
        if array?
          { terms: { @name => value } }
        else
          { match: { @name => value } }
        end
      end

      private

      def value
        array? ? array : @value
      end

      def array?
        array.length > 1
      end

      def array
        @array ||= @value.split(",")
      end
    end
  end
end
