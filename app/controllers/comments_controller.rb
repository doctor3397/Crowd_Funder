class CommentsController < ApplicationController
  before_action :load_project




 def show
    @comment = Comment.find(params[:id])
  end

 def create
    @comment = Comment.new(comment_params)
      @comment.project_id =  @project.id
      @comment.user_id = current_user.id



   if @comment.save
      redirect_to projects_url, notice: 'comment created successfully'
    else
      render 'projects/show'
    end

 end


 private
  def comment_params
    params.require(:comment).permit(:comment, :project_id, :id)
  end

  def load_project
     @project = Project.find(params[:project_id])
  end

end
