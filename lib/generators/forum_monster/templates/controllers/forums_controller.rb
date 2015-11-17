class Forum::ForumsController  < ApplicationController

  def show
    @forum = Forum.find(params[:id])
  end

  def new
    @forum = Forum.new
  end

  def create
    @forum = Forum.new(permitted_params)

    if @forum.save
      flash[:notice] = t('forums.controllers.forums.created_success')
      redirect_to forums_url
    else
      render :action => 'new'
    end
  end

  def edit
    @forum = Forum.find(params[:id])
  end

  def update
    @forum = Forum.find(params[:id])

    if @forum.update_attributes(permitted_params)
      flash[:notice] = t('forums.controllers.forums.updated_success')
      redirect_to forum_url(@forum)
    end
  end

  def destroy
    @forum = Forum.find(params[:id])

    if @forum.destroy
      flash[:notice] = t('forums.controllers.forums.deleted_success')
      redirect_to forums_url
    end
  end

  private

    def permitted_params
      params.require(:forum).permit(:title, :description, :state, :position, :category_id)
    end
end
