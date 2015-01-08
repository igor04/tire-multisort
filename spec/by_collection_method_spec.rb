require 'helper'

describe "Tire::Search::MultiSort" do
  subject(:search) { Tire::Search::Search.new }

  context 'by_collection method' do
    it 'simple collection' do
      search.multi_sort(:sort, :asc) do
        by_default :sort_field

        by :name
        by :sort_field, :asc
        by :sort_param2, :sort_field2, :desc

        by_collection :sort, :sort_param2, :sort_field, :name
        by_collection :sort2, :name, :sort_field, :sort_param2
      end

      expect(search.sort.to_ary).to eq [{sort_field2: :desc}, {sort_field: :asc}, {name: :asc}]
    end

    it 'with the same name as existed sort' do
      search.multi_sort(:sort, :asc) do
        by_default :sort_field

        by :sort
        by :name
        by :sort_field, :asc
        by :sort_param2, :sort_field2, :desc

        by_collection :sort, :sort_param2, :sort_field, :name
      end

      expect(search.sort.to_ary).to eq [{sort_field2: :desc}, {sort_field: :asc}, {name: :asc}]
    end

    it 'ignore with multiple sort' do
      search.multi_sort('sort,name,sort_param2', :asc) do
        by_default :sort_field

        by :sort
        by :name
        by :sort_field, :asc
        by :sort_param2, :sort_field2, :desc

        by_collection :sort, :sort_param2, :sort_field, :name
      end

      expect(search.sort.to_ary).to eq [{sort: :asc}, {name: :asc}, {sort_field2: :desc}]
    end

    it 'with incorrect sort parameter' do
      search.multi_sort(:sort, :asc) do
        by_default :sort_field

        by :sort
        by :name
        by :sort_field, :asc
        by :sort_param2, :sort_field2, :desc

        by_collection :sort, :sort_param2, :sort_field, :name2
      end

      expect(search.sort.to_ary).to eq [{sort_field2: :desc}, {sort_field: :asc}]
    end
  end
end
