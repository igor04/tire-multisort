module Tire
  module Search

    class Search
      attr_reader :sort

      # sort: "category,name,distance,.." or single "category", :category
      # order: "asc", :desc
      # block methods: by, by_default, by_collection
      #
      def multi_sort(sort, order, &block)
        @sort = MultiSort.new(sort, order, &block).to_ary

        self
      end
    end
  end
end
