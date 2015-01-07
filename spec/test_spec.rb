require 'helper'

describe "Tire::Search" do
  it 'multi_sort' do
    expect(Tire::Search::Search.new).to respond_to :multi_sort
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
