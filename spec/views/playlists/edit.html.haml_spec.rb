require 'spec_helper'

describe "playlists/edit" do
  before(:each) do
    @playlist = assign(:playlist, stub_model(Playlist,
      :user_id => 1,
      :session_id => 1,
      :search_term => "MyString"
    ))
  end

  it "renders the edit playlist form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => playlists_path(@playlist), :method => "post" do
      assert_select "input#playlist_user_id", :name => "playlist[user_id]"
      assert_select "input#playlist_session_id", :name => "playlist[session_id]"
      assert_select "input#playlist_search_term", :name => "playlist[search_term]"
    end
  end
end
