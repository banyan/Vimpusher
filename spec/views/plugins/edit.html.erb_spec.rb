require 'spec_helper'

describe "plugins/edit" do
  before(:each) do
    @plugin = assign(:plugin, stub_model(Plugin))
  end

  it "renders the edit plugin form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => plugins_path(@plugin), :method => "post" do
    end
  end
end
