module ElasticsearchQuery
  module FilterFormatter
    class Range < Base
      INFINITY = 'inf'.freeze
      NEGATIVE_INFINITY = 'neginf'.freeze

      def to_hash
        return nil if all_the_values?

        range = {}.tap do |range|
          range[ :gte ] = beginning unless negative_infinity?( beginning )
          range[ :lt ]  = ending    unless infinity?( ending )
        end

        { range: { @name => range } }
      end

      private

      def range
        @range ||= self.class.parser.new( @value ).parse
      end

      def beginning
        @beginning ||= range.first
      end

      def ending
        @ending ||= range.last
      end

      def all_the_values?
        infinity?( ending ) && negative_infinity?( beginning )
      end

      def infinity?( value )
        value == INFINITY
      end

      def negative_infinity?( value )
        value == NEGATIVE_INFINITY
      end

      class << self
        attr_accessor :parser
      end
    end
  end
end