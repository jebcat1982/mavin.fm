require 'spec_helper'

describe "albums/edit" do
  before(:each) do
    @album = assign(:album, stub_model(Album,
      :title => "MyString",
      :release_date => 1,
      :downloadable => 1,
      :url => "MyString",
      :about => "MyText",
      :credits => "MyText",
      :small_art_url => "MyString",
      :large_art_url => "MyString",
      :artist => "MyString",
      :band_id => 1,
      :e_id => 1,
      :e_band_id => 1
    ))
  end

  it "renders the edit album form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => albums_path(@album), :method => "post" do
      assert_select "input#album_title", :name => "album[title]"
      assert_select "input#album_release_date", :name => "album[release_date]"
      assert_select "input#album_downloadable", :name => "album[downloadable]"
      assert_select "input#album_url", :name => "album[url]"
      assert_select "textarea#album_about", :name => "album[about]"
      assert_select "textarea#album_credits", :name => "album[credits]"
      assert_select "input#album_small_art_url", :name => "album[small_art_url]"
      assert_select "input#album_large_art_url", :name => "album[large_art_url]"
      assert_select "input#album_artist", :name => "album[artist]"
      assert_select "input#album_band_id", :name => "album[band_id]"
      assert_select "input#album_e_id", :name => "album[e_id]"
      assert_select "input#album_e_band_id", :name => "album[e_band_id]"
    end
  end
end
