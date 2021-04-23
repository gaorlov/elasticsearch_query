module ElasticsearchQuery
  module FilterFormatter
    autoload :Base,  'elasticsearch_query/filter_formatter/base'
    autoload :Custom,'elasticsearch_query/filter_formatter/custom'
    autoload :Match, 'elasticsearch_query/filter_formatter/match'
    autoload :Range, 'elasticsearch_query/filter_formatter/range'

    class << self
      def formatter_for( value )
        case value
        when String
          !!value.match( /\.\./ ) ? FilterFormatter::Range : FilterFormatter::Match
        when Hash
          FilterFormatter::Custom
        end
      end
    end
  end
end