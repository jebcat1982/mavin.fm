require 'spec_helper'

describe "playlist_tracks/new" do
  before(:each) do
    assign(:playlist_track, stub_model(PlaylistTrack,
      :playlist_id => 1,
      :track_id => 1
    ).as_new_record)
  end

  it "renders new playlist_track form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => playlist_tracks_path, :method => "post" do
      assert_select "input#playlist_track_playlist_id", :name => "playlist_track[playlist_id]"
      assert_select "input#playlist_track_track_id", :name => "playlist_track[track_id]"
    end
  end
end
