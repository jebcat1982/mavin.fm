require 'spec_helper'

describe "playlist_tracks/show" do
  before(:each) do
    @playlist_track = assign(:playlist_track, stub_model(PlaylistTrack,
      :playlist_id => 1,
      :track_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
  end
end
