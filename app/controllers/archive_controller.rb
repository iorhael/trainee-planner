# frozen_string_literal: true

class ArchiveController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event, only: %i[show destroy]

  def index
    @events = search(search_params).ordered_by_time(:desc).page(params[:page]).per(params[:per_page])
  end

  def show; end

  def destroy
    if @event.destroy
      redirect_to archive_index_path, info: t('flash.event.destroy'), status: :see_other
    else
      redirect_to archive_index_path, error: @events.errors.full_messages.to_sentence
    end
  end

  def destroy_all
    if search(search_params).destroy_all
      redirect_to archive_index_path, info: t('flash.event.destroy_all'), status: :see_other
    else
      redirect_to archive_index_path, error: @events.errors.full_messages.to_sentence
    end
  end

  private

  def search(search_params)
    SearchService.new(search_params:, default_relation: current_user.events.in_past).call
  end

  def search_params
    params.permit(:name, :category_name)
  end

  def event_params
    params.require(:event).permit(:name, :event_time, :description, :category_id)
  end

  def set_event
    @event = current_user.events.in_past.find(params[:id])
  end
end
