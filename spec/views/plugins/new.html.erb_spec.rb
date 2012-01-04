require 'spec_helper'

describe "plugins/new.html.erb" do
  before(:each) do
    assign(:plugin, stub_model(Plugin).as_new_record)
  end

  it "renders new plugin form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => plugins_path, :method => "post" do
    end
  end
end
