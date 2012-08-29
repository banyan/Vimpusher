require 'spec_helper'

describe HomeController do
  describe "GET 'index'" do
    let(:request) { get :index }
    subject &:request

    context "when successful" do
      it "should render" do
        response.should be_success
        response.code.should eq("200")
      end
    end
  end
end
