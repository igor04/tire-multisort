require 'helper'

describe "Tire::Search::MultiSort" do
  subject(:search) { Tire::Search::Search.new }

  context 'by method' do
    it 'with alias and predefined order' do
      search.multi_sort(:sort_param, :desc) do
        by :sort_param,  :sort_field,  :asc
        by :sort_param2, :sort_field2, :desc
      end

      expect(search.sort.to_ary).to eq [{sort_field: :asc}]
    end

    it 'with alias' do
      search.multi_sort(:sort_param, :desc) do
        by :sort_param,  :sort_field
        by :sort_param2, :sort_field2
      end

      expect(search.sort.to_ary).to eq [{sort_field: :desc}]
    end

    it 'without alias and with predefined order' do
      search.multi_sort(:sort_field, :desc) do
        by :sort_field, :asc
        by :sort_field2, :order
      end

      expect(search.sort.to_ary).to eq [{sort_field: :asc}]
    end

    it 'without alias' do
      search.multi_sort(:sort_field, :desc) do
        by :sort_field
        by :sort_field2
      end

      expect(search.sort.to_ary).to eq [{sort_field: :desc}]
    end

    it 'with multiple sort' do
      search.multi_sort('sort_field2,sort_field,sort_param2,sort_param', :desc) do
        by :sort_field
        by :sort_field2
        by :sort_param, :sort_field3
        by :sort_param2, :sort_field4, :asc
      end

      expect(search.sort.to_ary).to eq [{sort_field2: :desc}, {sort_field: :desc}, {sort_field4: :asc}, {sort_field3: :desc}]
    end

    it 'with incorrect multiple sort parameter' do
      search.multi_sort('sort_field0,sort_field,sort_param2,sort_param', :desc) do
        by :sort_field
        by :sort_field2
        by :sort_param, :sort_field3
        by :sort_param2, :sort_field4, :asc
      end

      expect(search.sort.to_ary).to eq [{sort_field: :desc}, {sort_field4: :asc}, {sort_field3: :desc}]
    end

    it 'with multiple sort and spaces' do
      search.multi_sort(' sort_field, sort_param2, sort_param ', :desc) do
        by :sort_field
        by :sort_field2
        by :sort_param, :sort_field3
        by :sort_param2, :sort_field4, :asc
      end

      expect(search.sort.to_ary).to eq [{sort_field: :desc}, {sort_field4: :asc}, {sort_field3: :desc}]
    end

    it 'with invert' do
      order = :asc

      search.multi_sort(:sort_field, order) do
        by :sort_field, invert(order)
        by :sort_field2
        by :sort_param, :sort_field3
        by :sort_param2, :sort_field4, :asc
      end

      expect(search.sort.to_ary).to eq [{sort_field: :desc}]
    end

    it 'with additional parameters' do
      search.multi_sort(:distance, :asc) do
        by :sort_param, :sort_field3
        by :sort_param2, :sort_field4, :asc
        by :distance, :_geo_distance, location: "test", unit: 'mi'
      end

      expect(search.sort.to_ary).to eq  [{_geo_distance: {location: "test", unit: "mi", order: :asc}}]
    end
  end
end
