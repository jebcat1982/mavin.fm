require 'spec_helper'

describe "albums/show" do
  before(:each) do
    @album = assign(:album, stub_model(Album,
      :title => "Title",
      :release_date => 1,
      :downloadable => 1,
      :url => "Url",
      :about => "MyText",
      :credits => "MyText",
      :small_art_url => "Small Art Url",
      :large_art_url => "Large Art Url",
      :artist => "Artist",
      :band_id => 1,
      :e_id => 1,
      :e_band_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Url/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Small Art Url/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Large Art Url/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Artist/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
  end
end
