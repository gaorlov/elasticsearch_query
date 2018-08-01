module ElasticsearchQuery
  class Sort
    def initialize( params = {} )
      @params  = params
    end

    def to_hash
      return {} if sorts&.empty?
      if sorts.length == 1
        { sort: sorts.first }
      else
        { sort: sorts }
      end
    end

    private

    def sorts
      @sorts ||= begin
        sorts = @params.fetch( :sort, "" ).split(',')

        sorts.each_with_object([]) do |field, arr|
          desc, field   = field.match(/^([-_])?(\w+)$/i)[1..2]
          arr << { field => desc ? :desc : :asc }
        end
      end
    end
  end
end