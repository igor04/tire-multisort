require 'helper'

describe "Tire::Search::MultiSort" do
  subject(:search) { Tire::Search::Search.new }

  context 'by_default method' do
    it 'with invalid sort parameter' do
      search.multi_sort(:invalid_sort, :asc) do
        by_default :sort_field

        by :sort_field
        by :sort_field2
      end

      expect(search.sort.to_ary).to eq [{sort_field: :asc}]
    end

    it 'with missing sort parameter' do
      search.multi_sort(nil, :asc) do
        by_default :sort_field

        by :sort_field
        by :sort_field2
      end

      expect(search.sort.to_ary).to eq [{sort_field: :asc}]
    end

    it 'could be redefined' do
      search.multi_sort(nil, :asc) do
        by_default :sort_field

        by :sort_field, :asc
        by :sort_param2, :sort_field2, :desc

        by_default :sort_param2
      end

      expect(search.sort.to_ary).to eq [{sort_field2: :desc}]
    end

    it 'ignore when sort correct' do
      search.multi_sort(:sort_param2, :asc) do
        by_default :sort_field

        by :sort_field, :asc
        by :sort_param2, :sort_field2, :desc
      end

      expect(search.sort.to_ary).to eq [{sort_field2: :desc}]
    end

    it 'with sort collection' do
      search.multi_sort(nil, :asc) do
        by_default :sort_param3

        by :sort_field
        by :sort_param2, :sort_field2, :desc

        by_collection :sort_param3,   [:sort_field, :sort_param2]
      end

      expect(search.sort.to_ary).to eq [{sort_field: :asc}, {sort_field2: :desc}]
    end
  end
end
