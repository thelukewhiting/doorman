class TwiliosController < ApplicationController

  def incoming

    @name = "Luke"
      
    render action: "incoming.xml.builder", :layout => false

  end

end
