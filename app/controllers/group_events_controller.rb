class GroupEventsController < ApplicationController
  before_action :get_user
  before_action :get_group_event, only: [:edit, :update, :destroy]

  def index
    @group_events = @user.group_events
  end

  def new
    @group_event = @user.group_events.new
  end

  def create
    @group_event = @user.group_events.new(group_event_params)
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

  def destroy
    @group_event.destroy
    redirect_to group_events_path,
    notice: "#{@group_event.name} has been successfully deleted"
  end

  def deleted
    @group_events = @user.group_events.deleted_group_events
  end

  private

  def group_event_params
    params.require(:group_event).permit(:name, :description, :location, :start_on, :end_on, :published)
  end

  def get_group_event
    @group_event = GroupEvent.find(params[:id])
  end
end
