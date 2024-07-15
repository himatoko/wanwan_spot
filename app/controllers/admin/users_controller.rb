class Admin::UsersController < ApplicationController
  def destroy
    @user = User.find(params[id])
    @user.destroy
    redirect_to admin_dashbords_path, notice: 'ユーザーを削除しました'
  end
end
