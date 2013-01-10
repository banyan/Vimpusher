require 'spec_helper'

describe UsersController do
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

  describe "GET 'new'" do
    let(:request) { get :new }
    subject &:request

    context "when successful" do
      it "should render" do
        response.should be_success
        response.code.should eq("200")
      end
    end
  end

  describe "GET 'show'" do
    let(:request) { get :show }
    subject &:request

    context "when successful" do
      it "should render" do
        response.should be_success
        response.code.should eq("200")
      end
    end
  end
end
