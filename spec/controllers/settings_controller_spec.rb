require 'spec_helper'

describe SettingsController do
  
  describe "GET #new" do
    it "should not render the #new view if not logged in" do
      get :new 
      response.should_not render_template :new
    end
  end  
end