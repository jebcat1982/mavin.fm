require 'spec_helper'

describe "playlists/index" do
  before(:each) do
    assign(:playlists, [
      stub_model(Playlist,
        :user_id => 1,
        :session_id => 1,
        :search_term => "Search Term"
      ),
      stub_model(Playlist,
        :user_id => 1,
        :session_id => 1,
        :search_term => "Search Term"
      )
    ])
  end

  it "renders a list of playlists" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Search Term".to_s, :count => 2
  end
end
