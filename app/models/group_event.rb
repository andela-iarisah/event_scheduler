class GroupEvent < ActiveRecord::Base
  belongs_to :user

  validate :no_past_date, :valid_date

  private

  def no_past_date
    errors.add(:start_on, "must be today or after today") if start_on < Date.today
  end

  def valid_date
    errors.add(:end_on, "must be after state date") if start_on >= end_on
  end
end
