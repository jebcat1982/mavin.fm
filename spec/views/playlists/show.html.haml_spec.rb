require 'spec_helper'

describe "playlists/show" do
  before(:each) do
    @playlist = assign(:playlist, stub_model(Playlist,
      :user_id => 1,
      :session_id => 1,
      :search_term => "Search Term"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Search Term/)
  end
end
