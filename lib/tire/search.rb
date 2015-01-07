module Tire
  module Search

    class Search
      def multi_sort(&block)
        @sort = MultiSort.new(&block).to_ary
        self
      end
    end
  end
end
