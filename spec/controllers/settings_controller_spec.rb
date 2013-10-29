require 'spec_helper'

describe SettingsController do
  
  describe "GET #new" do
    it "should not render #new if not authenticated" do
      get :new 
      response.should_not render_template :new
    end
  end  

  describe "GET #edit" do
    it "should not render #edit if not authenticated" do
      get :edit, id: 1
      response.should_not render_template :edit
    end
  end


end