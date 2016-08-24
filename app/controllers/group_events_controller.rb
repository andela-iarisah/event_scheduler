class GroupEventsController < ApplicationController
  before_action :get_user
  before_action :get_group_event, only: [:edit, :update]

  def index
    @group_events = GroupEvent.all
  end

  def new
    @group_event = @user.group_events.new
  end

  def create
    @group_event = @user.group_events.create(group_event_params)
    if @group_event.save
      redirect_to group_events_path, notice: 'Group Event successfully created'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @group_event.update_attributes(group_event_params)
      redirect_to group_events_path,
      notice: "#{@group_event.name} has been successfully updated"
    else
      render :edit
    end
  end

  private

  def group_event_params
    params.require(:group_event).permit(:name, :description, :location, :start_on, :end_on, :published)
  end

  def get_group_event
    @group_event = GroupEvent.find(params[:id])
  end
end
