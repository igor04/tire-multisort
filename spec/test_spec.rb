require 'helper'

describe "Tire::Search" do
  subject(:search) { Tire::Search::Search.new }

  it 'multi_sort present' do
    expect(search).to respond_to :multi_sort
  end

  it 'multi_sort with declared order' do
    search.multi_sort(:sort_by, :asc) do
      by :sort_by, :field, :order
      by :sort_by2, :field2, :order2
    end

    expect(search.sort.to_ary).to eq [{field: :order}]
  end

  it 'multi_sort with declared order' do
    search.multi_sort(:sort_by, :asc) do
      by :sort_by, :field
      by :sort_by2, :field2
    end

    expect(search.sort.to_ary).to eq [{field: :asc}]
  end
end

describe "Tire::Search::MultiSort" do
  it 'multi sort' do
    x= Tire::Search::MultiSort.new
    x.by :xx, :y
    p x.to_ary
    # expect().to eq 2
  end
end
