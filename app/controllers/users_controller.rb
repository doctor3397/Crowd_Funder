class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      auto_login(@user)
      redirect_to projects_url
    else
      render 'new'
    end
  end

  def show
    #
    # @rewards_id = []
    # @pledge_dollar_amounts = []
    @projects = []

    @user = User.find(params[:id])
    @pledges = Pledge.where(user_id: params[:id])
    @pledges.each do |pledge|
      @projects << pledge.reward.project
      #@pledge_dollar_amounts << pledge.dollar_amount
    end
    # Project.all.rewards.each do |reward|
    #   reward.pledges.where(user_id: params[:id]).each do |pledge|
    #     pledge.dollar_amount
    #   end
    # end

    #@projects = Project.all
    # @rewards_id.each do |reward_id|
    #   @projects << Reward.find(reward_id).project
    # end
    # reward_id = Pledge.find_by(user_id:6).reward_id
    # @project = Reward.find(reward_id).project
   end



  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
