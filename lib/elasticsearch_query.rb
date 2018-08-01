require "elasticsearch_query/version"

module ElasticsearchQuery
  autoload :Filter,           'elasticsearch_query/filter'
  autoload :Filters,          'elasticsearch_query/filters'
  autoload :FilterFormatter,  'elasticsearch_query/filter_formatter'
  autoload :Query,            'elasticsearch_query/query'
  autoload :Sort,             'elasticsearch_query/sort'

  def self.from_params( params = {} )
    Query.new( params )
  end
end