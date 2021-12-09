class UsersController < ApplicationController
  def edit
  end

  def update
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.js {render nothing: true} 
        format.html { redirect_to @post, notice: "Post was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end
end
