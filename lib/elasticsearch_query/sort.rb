module ElasticsearchQuery
  class Sort
    def initialize( params = {}, default = "" )
      @params  = params
      @default = default
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
        sorts = @params.fetch( :sort, @default ).split(',')

        sorts.each_with_object([]) do |field, arr|
          desc, field   = field.match(/^([-_])?(\w+)$/i)[1..2]
          arr << { field => desc&.empty? ? :asc : :desc }
        end
      end
    end
  end
end