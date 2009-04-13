class TimesheetsController < ApplicationController
  include TimesheetsHelper
  
  before_filter :require_user
  
  def index
    @user = @current_user
    respond_to do |format|
      format.html
      format.xml { render :xml => @user.timesheets }
    end
  end
  
  def edit
    @user = @current_user
    
    begin
      @date = Date.new(params[:year].to_i, params[:month].to_i, params[:day].to_i)
      return render :file => "#{RAILS_ROOT}/public/404.html",  
        :status => 404 unless @date == @date.beginning_of_week
    rescue ArgumentError
      return render :file => "#{RAILS_ROOT}/public/404.html", :status => 404
    end
 
    @timesheet = Timesheet.scoped_by_user_id(@user.id).find_by_start_date(@date)
    
    unless @timesheet
      @timesheet = Timesheet.new({:user => @user, :start_date => @date})
      @timesheet.time_entries.build
    end
    
    respond_to do |format|
      format.html # edit.html.erb
      format.xml { render :xml => @timesheet }
    end
  end
  
  def create
    @timesheet = Timesheet.new(params[:timesheet])
    @date = @timesheet.start_date
    respond_to do |format|
      if @timesheet.save
        flash[:notice] = 'Timesheet was successfully saved.'
        format.html { redirect_to "#{timesheets_path}/#{date_path(@date)}" }
        format.xml { render :xml => @timesheet, :status => :created, :location => @timesheet }
      else
        format.html { redirect_to "#{timesheets_path}/#{date_path(@date)}" }
        format.xml  { render :xml => @timesheet.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def update
    @timesheet = Timesheet.find(params[:id])
    @date = @timesheet.start_date
    respond_to do |format|
      if @timesheet.update_attributes(params[:timesheet])
        flash[:notice] = 'Timesheet was successfully saved.'
        format.html { redirect_to "#{timesheets_path}/#{date_path(@date)}" }
        format.xml { head :ok }
      else
        format.html { redirect_to "#{timesheets_path}/#{date_path(@date)}" }
        format.xml  { render :xml => @timesheet.errors, :status => :unprocessable_entity }
      end
    end
  end
end
