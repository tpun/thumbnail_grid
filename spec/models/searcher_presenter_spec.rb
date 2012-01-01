require_relative '../../models/search_presenter.rb'

describe "SearchPresenter" do
  let(:searcher) { Searcher.new stub }
  let(:fixed_width) { 1000 }
  subject { SearchPresenter.new  searcher, fixed_width }

  describe "#items_per_row" do
    let(:item1) { stub :width=>500, :height=>100 }
    let(:item2) { stub :width=>400, :height=>200 }
    let(:item3) { stub :width=>200, :height=>100 }
    before :each do
      searcher.stub :results => [item1, item2, item3]
    end

    it "picks the right number of items to be fitted in a row" do
      subject.items_per_row.should == [item1, item2]
    end

    let(:item1_adjust) { stub :width => 600, :height => 100*600/500 }
    it "resizes one of the items which minimizes change in the row's height" do
      pending
      subject.items_per_row.should == [item1_adjusted, item2]
    end
  end

  describe "#write_thumbnail_grid" do
    it "creates a file"
  end
end