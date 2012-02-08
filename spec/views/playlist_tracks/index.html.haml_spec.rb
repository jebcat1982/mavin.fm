require 'spec_helper'

describe "playlist_tracks/index" do
  before(:each) do
    assign(:playlist_tracks, [
      stub_model(PlaylistTrack,
        :playlist_id => 1,
        :track_id => 1
      ),
      stub_model(PlaylistTrack,
        :playlist_id => 1,
        :track_id => 1
      )
    ])
  end

  it "renders a list of playlist_tracks" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
