class PledgesController < ApplicationController
  before_action :require_login

  def create
    @pledge = Pledge.new(pledge_params)
    @pledge.user = current_user
    @pledge.reward = Reward.find(params[:reward_id])

    if @pledge.save
      # Sends email to user when user is created.
      UserMailer.pledge_email(current_user).deliver_now

      redirect_to project_url(@pledge.project), notice: "You have successfully backed #{@pledge.project.title}!"
    else
      @project = @pledge.project
      render 'projects/show'
    end
  end

  private

  def pledge_params
    params.require(:pledge).permit(:dollar_amount)
  end
end
