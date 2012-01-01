require_relative '../../models/searcher.rb'

describe "Searcher" do
  let(:query) { 'apple' }
  let(:count_per_page) { 5 }
  let(:pages) { 2 }
  subject { Searcher.new query, count_per_page, pages }

  describe "#page" do
    it "returns one page of result" do
      subject.page(0).should have(count_per_page).thumbnails
    end
  end

  describe "#results" do
    let(:count) { count_per_page * pages }
    it "returns all results up to n pages (set internally)" do
      subject.results.should have(count).thumbnails
    end

    it "does not refetch" do
      subject.results
      subject.should_not_receive :page

      subject.results.should have(count).thumbnails
    end
  end
end