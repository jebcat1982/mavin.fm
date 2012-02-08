require 'spec_helper'

describe "tracks/new" do
  before(:each) do
    assign(:track, stub_model(Track,
      :title => "MyString",
      :number => 1,
      :duration => 1.5,
      :release_date => 1,
      :downloadable => 1,
      :url => "MyString",
      :streaming_url => "MyString",
      :lyrics => "MyText",
      :about => "MyText",
      :credits => "MyText",
      :small_art_url => "MyString",
      :large_art_url => "MyString",
      :artist => "MyString",
      :album_id => 1,
      :e_id => 1,
      :e_album_id => 1,
      :e_band_id => 1
    ).as_new_record)
  end

  it "renders new track form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => tracks_path, :method => "post" do
      assert_select "input#track_title", :name => "track[title]"
      assert_select "input#track_number", :name => "track[number]"
      assert_select "input#track_duration", :name => "track[duration]"
      assert_select "input#track_release_date", :name => "track[release_date]"
      assert_select "input#track_downloadable", :name => "track[downloadable]"
      assert_select "input#track_url", :name => "track[url]"
      assert_select "input#track_streaming_url", :name => "track[streaming_url]"
      assert_select "textarea#track_lyrics", :name => "track[lyrics]"
      assert_select "textarea#track_about", :name => "track[about]"
      assert_select "textarea#track_credits", :name => "track[credits]"
      assert_select "input#track_small_art_url", :name => "track[small_art_url]"
      assert_select "input#track_large_art_url", :name => "track[large_art_url]"
      assert_select "input#track_artist", :name => "track[artist]"
      assert_select "input#track_album_id", :name => "track[album_id]"
      assert_select "input#track_e_id", :name => "track[e_id]"
      assert_select "input#track_e_album_id", :name => "track[e_album_id]"
      assert_select "input#track_e_band_id", :name => "track[e_band_id]"
    end
  end
end
