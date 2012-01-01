require_relative '../../models/thumbnail.rb'

describe "Thumbnail" do
  let(:old_dim) { stub :width =>150, :height => 200}
  let(:new_dim) { stub :width =>300, :height => 400}
  subject { Thumbnail.new stub, old_dim.width, old_dim.height }

  describe "#new_height" do
    it "returns new height if thumbnail is to be resized to given width" do
      subject.new_height(new_dim.width-old_dim.width).should == new_dim.height
    end

    it "does not change @width" do
      expect { subject.new_height(new_dim.width) }.
        to_not change { subject.width }
    end
  end

  describe "#resize!" do
    it "resizes by given width" do
      expect { subject.resize! new_dim.width-old_dim.width }.
        to change { [subject.width, subject.height] }.
        from([old_dim.width, old_dim.height]).
        to([new_dim.width, new_dim.height])
    end
  end

end