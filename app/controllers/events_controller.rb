# frozen_string_literal: true

class EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event, only: %i[show update destroy]
  before_action :set_category, only: %i[create update]

  def index
    @events = search(search_params).ordered_by_time.page(params[:page]).per(params[:per_page])
  end

  def show
    @weather = Weather::DataHandler.new(event_time: @event.event_time).call
  end

  def create
    unless @category
      return redirect_to events_path, error: t('flash.event.create_with_unaccessible_category'),
                                      status: :unprocessable_entity
    end

    @event = @category.events.create(event_params)
    if @event.save
      redirect_to events_path, success: t('flash.event.create')
    else
      redirect_to events_path, error: @event.errors.full_messages.to_sentence
    end
  end

  def update
    unless @category
      return redirect_to events_path, error: t('flash.event.update_with_unaccessible_category'),
                                      status: :unprocessable_entity
    end

    if @event.update(event_params)
      redirect_to events_path, success: t('flash.event.update')
    else
      redirect_to events_path, error: @event.errors.full_messages.to_sentence
    end
  end

  def destroy
    if @event.destroy
      redirect_to events_path, info: t('flash.event.destroy'), status: :see_other
    else
      redirect_to events_path, error: @events.errors.full_messages.to_sentence
    end
  end

  private

  def search(search_params)
    SearchService.new(search_params:, default_relation: current_user.events).call
  end

  def search_params
    params.permit(:name, :category_name)
  end

  def event_params
    params.require(:event).permit(:name, :event_time, :description, :reminder_time, :category_id)
  end

  def set_category
    @category = current_user.categories.find_by(id: event_params[:category_id])
  end

  def set_event
    @event = Event.find(params[:id])
  end
end
