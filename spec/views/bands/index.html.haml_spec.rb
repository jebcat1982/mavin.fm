require 'spec_helper'

describe "bands/index" do
  before(:each) do
    assign(:bands, [
      stub_model(Band,
        :url => "Url",
        :e_id => 1,
        :subdomain => "Subdomain",
        :name => "Name",
        :offsite_url => "Offsite Url"
      ),
      stub_model(Band,
        :url => "Url",
        :e_id => 1,
        :subdomain => "Subdomain",
        :name => "Name",
        :offsite_url => "Offsite Url"
      )
    ])
  end

  it "renders a list of bands" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Url".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Subdomain".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Offsite Url".to_s, :count => 2
  end
end
