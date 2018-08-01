$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "simplecov"

SimpleCov.start

require "elasticsearch_query"

class DummyPaginator
  def initialize( params )
    @params = params
  end

  def limit
    @limit ||= ( @params.dig( :page, :limit ) || 20 ).to_i
  end

  def offset
    @offset ||= ( @params.dig( :page, :offset ) || 0 ).to_i
  end

  def to_hash
    {  size: limit,
       from: offset }
  end
end

class DotDotRangeParser
  def initialize( value )
    @value = value
  end

  def parse
    @value.split ".."
  end
end

class Params
  def initialize( value_hash )
    @value = value_hash
  end

  def to_unsafe_hash
    self
  end

  def with_indifferent_access
  end

  def [](key)
    @value[ key.to_s ] || @value[ key.to_sym ]
  end
end

ElasticsearchQuery::Query.paginator_class = DummyPaginator
ElasticsearchQuery::FilterFormatter::Range.parser = DotDotRangeParser

require "minitest/autorun"