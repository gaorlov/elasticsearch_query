module ElasticsearchQuery
  class Query
    def initialize( params )
      if params.respond_to? :with_indifferent_acess
        @params = params.with_indifferent_acess
      else
        @params = params
      end
    end

    def sort
      @_sort ||= Sort.new @params
    end

    def filters
      @_filters ||= Filters.new @params
    end

    def paginator
      @_paginator ||= self.class.paginator_class.new @params
    end

    def to_hash
      @hash ||= begin
        base_query
          .merge sort.to_hash
          .merge paginator.to_hash
      end
    end

    def to_count_hash
      base_query
    end

    private

    def base_query
      @base_query ||= { query: filters.to_hash }
    end

    class << self
      attr_accessor :paginator_class
    end
  end
end