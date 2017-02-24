class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.welcome_email(@user).deliver_now
      auto_login(@user)
      redirect_back_or_to root_path
    else
      render 'new'
    end
  end

  def show
    @projects = []
    @user = User.find(params[:id])
    @owner_projects = Project.all.where(owner_id: @user.id)
    @pledges = Pledge.where(user_id: params[:id])
    @pledges.each do |pledge|
      @projects << pledge.reward.project
    end
    @projects = @projects.uniq

   end



  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
