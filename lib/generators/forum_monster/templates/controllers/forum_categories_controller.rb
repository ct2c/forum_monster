class Forum::ForumCategoriesController < ApplicationController

  def index
    @categories = ForumCategory.all
  end

  def new
    @category = ForumCategory.new
  end

  def create
    @category = ForumCategory.new(permitted_params)

    if @category.save
      flash[:notice] = t('forums.controllers.categories.created_success')
      redirect_to forums_url
    else
      render :action => 'new'
    end
  end

  def edit
    @category = ForumCategory.find(params[:id])
  end

  def update
    @category = ForumCategory.find(params[:id])

    if @category.update_attributes(permitted_params)
      flash[:notice] = t('forums.controllers.categories.updated_success')
      redirect_to forums_url
    end
  end

  def destroy
    @category = ForumCategory.find(params[:id])

    if @category.destroy
      flash[:notice] = t('forums.controllers.categories.deleted_success')
      redirect_to forums_url
    end
  end

  private

    def permitted_params
      params.require(:forum_category).permit(:title, :state, :position, :forum_category_id)
    end

end
