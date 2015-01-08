module Tire
  module Search

    # EXAMPLE of using:
    #
    #
    # multi_sort sort, order do
    #
    #   by_default :premium
    #
    #   by :date
    #   by :rating,    invert(order)
    #
    #   by :name,      :title
    #   by :rating,    :licensee_rating
    #   by :relevance, :_score
    #   by :category,  :category_name
    #   by :distance,  :_geo_distance, location: "test", unit: 'mi'
    #   by :premium,   :premium, :desc
    #
    #   by_collection  :category,  :category, :name
    #   by_collection  :premium,   :premium, :relevance, :name
    #
    # end
    #
    class MultiSort < Sort

      alias :origin_by :by

      def initialize(sort_param, order, &block)
        @collections = {}
        @fields = {}

        super(&block)

        @sort = sort_by(sort_param)
        @order = order
        fields_with_order.each { |opts| origin_by *opts }
      end

      def by_default(sort_param)
        @default = sort_by(sort_param)
      end

      def by_collection(sort, *collection)
        @collections[sort] = collection
      end

      def by(sort, *options)
        if options.blank? || [:desc, :asc].include?(options.first)
          @fields[sort] = options.unshift(sort)
        else
          @fields[sort] = options
        end
      end

      def invert(order)
        order.to_s == 'asc' ? :desc : :asc
      end

      private

      def add_order_to_field(field)
        if field.size == 1
          field.push @order
        elsif field.last.is_a?(Hash) && !field.last.has_key?(:order)
          field.last.merge!(order: @order)
        end

        field
      end

      def fields_with_order
        @sort = @default if fields.empty?

        fields.map { |field| add_order_to_field field.dup }
      end

      def fields
        collections.map { |name| @fields[name.to_sym] }.compact
      end

      def collections
        @sort.size == 1 ? (@collections[@sort.first] || @sort) : @sort
      end

      def sort_by(param)
        param.to_s.split(',').map { |s| s.strip.to_sym }
      end
    end
  end
end
