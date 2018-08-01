module ElasticsearchQuery
  class Filter
    def initialize( name, value )
      @name  = name
      @value = value
    end

    def to_hash
      formatter_class.new( @name, @value ).to_hash
    end

    private

    def formatter_class
      @formatter_class ||= FilterFormatter.formatter_for( @value )
    end
  end
end