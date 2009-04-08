class ActivityTypesController < ApplicationController
  # GET /activity_types
  # GET /activity_types.xml
  def index
    @activity_types = ActivityType.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @activity_types }
    end
  end

  # GET /activity_types/1
  # GET /activity_types/1.xml
  def show
    @activity_type = ActivityType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @activity_type }
    end
  end

  # GET /activity_types/new
  # GET /activity_types/new.xml
  def new
    @activity_type = ActivityType.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @activity_type }
    end
  end

  # GET /activity_types/1/edit
  def edit
    @activity_type = ActivityType.find(params[:id])
  end

  # POST /activity_types
  # POST /activity_types.xml
  def create
    @activity_type = ActivityType.new(params[:activity_type])

    respond_to do |format|
      if @activity_type.save
        flash[:notice] = 'ActivityType was successfully created.'
        format.html { redirect_to(@activity_type) }
        format.xml  { render :xml => @activity_type, :status => :created, :location => @activity_type }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @activity_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /activity_types/1
  # PUT /activity_types/1.xml
  def update
    @activity_type = ActivityType.find(params[:id])

    respond_to do |format|
      if @activity_type.update_attributes(params[:activity_type])
        flash[:notice] = 'ActivityType was successfully updated.'
        format.html { redirect_to(@activity_type) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @activity_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /activity_types/1
  # DELETE /activity_types/1.xml
  def destroy
    @activity_type = ActivityType.find(params[:id])
    @activity_type.destroy

    respond_to do |format|
      format.html { redirect_to(activity_types_url) }
      format.xml  { head :ok }
    end
  end
end
