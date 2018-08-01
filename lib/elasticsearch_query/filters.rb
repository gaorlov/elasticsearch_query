module ElasticsearchQuery
  class Filters
    def initialize( params )
      @params = params
    end

    def to_hash
      if matches.length == 1
        matches.first
      else
        { bool: { must: matches } }
      end
    end

    private

    def matches
      @filters ||= begin
        @params.fetch( :filter, {} ).each_with_object( [] ) do | ( field, value ), arr |
          arr << Filter.new( field, value ).to_hash
        end.compact
      end
    end
  end
end
