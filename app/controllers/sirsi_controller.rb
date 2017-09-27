class SirsiController < ApplicationController
  def index
    # search box for a catkey to pull data back from Sirsi WS
  end

  def show
   # display parsed record using the catkey
   @catkey = "7564032"
   @record = SirsiService.new(@catkey).record
  end
end
