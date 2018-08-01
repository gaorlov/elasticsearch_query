module ElasticsearchQuery
  module FilterFormatter
    autoload :Base,  'elasticsearch_query/filter_formatter/base'
    autoload :Match, 'elasticsearch_query/filter_formatter/match'
    autoload :Range, 'elasticsearch_query/filter_formatter/range'

    class << self
      def formatter_for( value )
        !!value.match( /\.\./ ) ? FilterFormatter::Range : FilterFormatter::Match
      end
    end
  end
end