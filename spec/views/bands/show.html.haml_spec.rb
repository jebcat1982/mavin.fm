require 'spec_helper'

describe "bands/show" do
  before(:each) do
    @band = assign(:band, stub_model(Band,
      :url => "Url",
      :e_id => 1,
      :subdomain => "Subdomain",
      :name => "Name",
      :offsite_url => "Offsite Url"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Url/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Subdomain/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Offsite Url/)
  end
end
