class Admin::DashbordsController < ApplicationController
  layout 'admin'
  def index
    @users = User.all
  end
  
end
