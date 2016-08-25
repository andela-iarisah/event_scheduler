class Api::V1::GroupEventsController < Api::V1::BaseController
  before_action :get_group_event, only: [:show, :update, :destroy]
  before_action :add_default_start_and_end_date, only: :create

  def index
    group_events = GroupEvent.all
    render json: group_events
  end

  def show
    render json: @group_event
  end

  def create
    group_event = GroupEvent.new(group_event_params)
    if group_event.save
      render json: group_event
    else
      head :unprocessable_entity
    end
  end

  def update
    group_event = @group_event.update_attributes(group_event_params)
    if group_event
      render json: @group_event
    else
      head :unprocessable_entity
    end
  end

  def destroy
    @group_event.destroy
    head :no_content
  end

  def deleted
    group_events = GroupEvent.deleted_group_events
    render json: group_events
  end

  private

  def group_event_params
    params.permit(:name, :description, :location, :start_on, :end_on, :published)
  end

  def get_group_event
    @group_event = GroupEvent.find(params[:id])
    rescue ActiveRecord::RecordNotFound
    render json: {Error: "Group Event with id #{params[:id]} not found"}, status: 404
  end

  def add_default_start_and_end_date
    params[:start_on] = Date.today unless params[:start_on]
    params[:end_on] = (Date.today + 1) unless params[:end_on]
  end
end
