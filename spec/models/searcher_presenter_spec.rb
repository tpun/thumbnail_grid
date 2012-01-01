require_relative '../../models/search_presenter.rb'
require_relative '../../models/thumbnail.rb'

describe "SearchPresenter" do
  let(:searcher) { stub }
  let(:fixed_width) { 1000 }
  subject { SearchPresenter.new  searcher, fixed_width }

  describe "#items_per_row" do
    let(:item1) { Thumbnail.new stub, 500, 100 }
    let(:item2) { Thumbnail.new stub, 400, 200 }
    let(:item3) { Thumbnail.new stub, 200, 100 }
    before :each do
      searcher.stub :results => [item1, item2, item3]
    end

    it "picks the right number of items to be fitted in a row" do
      subject.items_per_row.should == [item1, item2]
    end

    let(:item1_adjusted) { item1.tap {|item| item.resize!(
                            fixed_width-(item1.width+item2.width)) } }
    it "resizes one of the items which minimizes change in the row's height" do
      subject.items_per_row.should == [item1_adjusted, item2]
    end
  end

  describe "#write_thumbnail_grid" do
    it "creates a file"
  end
end