require 'spec_helper'

describe "bands/new" do
  before(:each) do
    assign(:band, stub_model(Band,
      :url => "MyString",
      :e_id => 1,
      :subdomain => "MyString",
      :name => "MyString",
      :offsite_url => "MyString"
    ).as_new_record)
  end

  it "renders new band form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => bands_path, :method => "post" do
      assert_select "input#band_url", :name => "band[url]"
      assert_select "input#band_e_id", :name => "band[e_id]"
      assert_select "input#band_subdomain", :name => "band[subdomain]"
      assert_select "input#band_name", :name => "band[name]"
      assert_select "input#band_offsite_url", :name => "band[offsite_url]"
    end
  end
end
