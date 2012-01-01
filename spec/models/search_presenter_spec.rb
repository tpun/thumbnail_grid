require_relative '../../models/search_presenter.rb'
require_relative '../../models/thumbnail.rb'
require_relative '../../models/searcher.rb'

describe "SearchPresenter" do
  let(:query) { "blah"}
  let(:searcher) { Searcher.new query }
  let(:fixed_width) { 1000 }
  subject { SearchPresenter.new searcher, fixed_width }

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

    it "does not resize last row" do
      subject.items_per_row

      expect { subject.items_per_row }.
        to_not change { [item3.width, item3.height] }
    end
  end

  describe "#write_thumbnail_grid_html" do
    let(:filename) { "./write_thumbnail_grid_html.html"}
    before :each do
      File.delete filename if File.exist? filename
    end
    it "creates a file" do
      expect { subject.write_thumbnail_grid_html filename }.
        to change { File.exist? filename }.
        from(false).to(true)
      File.delete filename if File.exist? filename
    end
  end
end