
require File.expand_path("../../helper.rb", __FILE__)

describe Ashton::Framebuffer do
  before :all do
    $window ||= Gosu::Window.new 16, 16, false
    @testcard_image = Gosu::Image.new $window, media_path("simple.png")
  end

  before :each do
    @subject = described_class.new 16, 12
    @subject.render do
      @testcard_image.draw 0, 0, 0
    end
  end

  describe "cache" do
    it "should be a PixelCache" do
      @subject.cache.should be_kind_of Ashton::PixelCache
    end

    it "should be of the right size" do
      @subject.cache.width.should eq 16
      @subject.cache.height.should eq 12
    end

    it "should consider the Framebuffer its owner" do
      @subject.cache.owner.should eq @subject
    end
  end

  describe "refresh_cache" do
    it "should be defined" do
      @subject.should respond_to :refresh_cache
    end
  end

  describe "[]" do
    it "should return the color of the pixel" do
      @subject[0, 0].should eq Gosu::Color::WHITE
      @subject[0, 1].should eq Gosu::Color::RED
      @subject[0, 2].should eq Gosu::Color::GREEN
      @subject[0, 3].should eq Gosu::Color::BLUE
      @subject[0, 8].should eq Gosu::Color.rgba(0, 0, 0, 0)
    end

    it "should return a null colour outside the texture" do
      @subject[0, -1].should eq Gosu::Color.new 0
      @subject[-1, 0].should eq Gosu::Color.new 0
      @subject[16, 0].should eq Gosu::Color.new 0
      @subject[0, 12].should eq Gosu::Color.new 0
    end
  end

  describe "rgba" do
    it "should return the appropriate array of values" do
      @subject.rgba(0, 0).should eq [255, 255, 255, 255]
      @subject.rgba(0, 1).should eq [255, 0, 0, 255]
      @subject.rgba(0, 2).should eq [0, 255, 0, 255]
      @subject.rgba(0, 3).should eq [0, 0, 255, 255]
      @subject.rgba(0, 8).should eq [0, 0, 0, 0]
    end
  end

  describe "red" do
    it "should return the appropriate value" do
      @subject.red(0, 0).should eq 255
      @subject.red(0, 1).should eq 255
      @subject.red(0, 2).should eq 0
      @subject.red(0, 3).should eq 0
      @subject.red(0, 8).should eq 0
    end
  end

  describe "green" do
    it "should return the appropriate value" do
      @subject.green(0, 0).should eq 255
      @subject.green(0, 1).should eq 0
      @subject.green(0, 2).should eq 255
      @subject.green(0, 3).should eq 0
      @subject.green(0, 8).should eq 0
    end
  end

  describe "blue" do
    it "should return the appropriate value" do
      @subject.blue(0, 0).should eq 255
      @subject.blue(0, 1).should eq 0
      @subject.blue(0, 2).should eq 0
      @subject.blue(0, 3).should eq 255
      @subject.blue(0, 8).should eq 0
    end
  end

  describe "alpha" do
    it "should return the appropriate value" do
      @subject.alpha(0, 0).should eq 255
      @subject.alpha(0, 1).should eq 255
      @subject.alpha(0, 2).should eq 255
      @subject.alpha(0, 3).should eq 255
      @subject.alpha(0, 8).should eq 0
    end
  end

  describe "transparent?" do
    it "should be false where the buffer is opaque or semi-transparent" do
      @subject.transparent?(0, 1).should eq false
      @subject.transparent?(0, 5).should eq false
    end

    it "should be true where the buffer is transparent" do
      @subject.transparent?(0, 8).should eq true
    end
  end

  describe "width" do
    it "should be initially set" do
      @subject.width.should eq 16
    end
  end

  describe "height" do
    it "should be initially set" do
      @subject.height.should eq 12
    end
  end

  describe "render" do
    it "should fail without a block" do
      ->{ @subject.render }.should raise_error ArgumentError
    end

    it "should passing itself into the block" do
      buffer = nil
      @subject.render do |fb|
        buffer = fb
      end

      buffer.should eq @subject
    end

    it "should bind the rendering during the block" do
      pending
    end

    it "should reset to rendering to the window after the block" do
      pending
    end

    it "should fail without a block" do
      lambda { @subject.render }.should raise_error ArgumentError
    end
  end

  describe "clear" do
    it "should clear the buffer to transparent" do
      pending
    end

    it "should clear the buffer to a specified color" do
      pending
    end
  end

  describe "draw" do
    pending
  end

  describe "to_image" do
    before :each do
      @image = @subject.to_image
    end

    it "should create an image of the appropriate size" do
      @image.width.should eq 16
      @image.height.should eq 12
    end
  end
end