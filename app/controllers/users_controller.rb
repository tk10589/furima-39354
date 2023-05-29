class UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path
    else
      render root_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:nickname, :fname, :lname, :fname_kana, :lname_kana, :birthdate)
  end
end
