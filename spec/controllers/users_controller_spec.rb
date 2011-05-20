require 'spec_helper'

describe UsersController do

  describe "GET index" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
  end

  describe "GET 'show'" do
    before(:each) do
      @user = User.create(:name => 'User', :email => 'email@localhost.com', :password => '123456', :avatar => 'missing.jpg')
      @user.save
    end

    it "should be successful" do
      get 'show', :id => @user.to_param
      response.should be_success
    end

    it "should destroy user" do
      delete :destroy => @user
      response.should be_success
    end
  end

  describe "POST 'new'" do
    before(:each) do
      @user = User.create(:name => 'User', :email => 'email@localhost.com', :password => '123456')
      @user.save
    end

    it 'should create new user' do
      response.should be_success
    end
  end

  describe "PUT 'update'" do
    before(:each) do
      @user = User.create(:name => 'User', :email => 'email@localhost.com', :password => '123456')
      @user.save
    end

    it 'should update current user' do
      @user.update_attributes(:name => 'User', :email => 'email@localhost.com', :password => '654321')
      @user.save

      response.should be_success
    end
  end
end
