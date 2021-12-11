class CommentsController < InheritedResources::Base

  def create
    @comment = Comment.new(comment_params.merge(user: current_user))
    
    respond_to do |format|
      if @comment.save
        format.html { redirect_to root_path, notice: "Comment was successfully created." }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end
  
  private

    def comment_params
      params.require(:comment).permit(:content, :user_id, :post_id)
    end

end
