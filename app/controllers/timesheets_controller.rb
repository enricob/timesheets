class TimesheetsController < ApplicationController
  before_filter :require_user
  
  def index
    @user = @current_user
  end
  
  def edit
    @user = @current_user
    @date = Date.new(params[:year].to_i, params[:month].to_i, params[:day].to_i)
    @timesheet = Timesheet.scoped_by_user_id(@user.id).find_by_start_date(@date)
    unless @timesheet
      @timesheet = Timesheet.create({:user => @user, :start_date => @date})
      @timesheet.time_entries.build
    end
  end
end
