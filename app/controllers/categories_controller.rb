# frozen_string_literal: true

class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_category, only: %i[update destroy]

  def index
    @categories = current_user.categories.order(:id)
  end

  def new
    @category = Category.new
  end

  def create
    @category = current_user.categories.create(category_params)
    if @category.save
      redirect_to categories_path, success: t('flash.category.create')
    else
      redirect_to categories_path, error: @category.errors.full_messages.to_sentence
    end
  end

  def update
    if @category.update(category_params)
      redirect_to categories_path, success: t('flash.category.update')
    else
      redirect_to categories_path, error: @category.errors.full_messages.to_sentence
    end
  end

  def destroy
    @category.destroy
    redirect_to categories_path, info: t('flash.category.destroy'), status: :see_other
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def set_category
    @category = Category.find(params[:id])
  end
end
