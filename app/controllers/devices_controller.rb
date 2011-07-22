class DevicesController < ApplicationController
  load_and_authorize_resource

  # GET /devices
  # GET /devices.xml
  def index
    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /devices/1
  # GET /devices/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /devices/new
  # GET /devices/new.xml
  def new
    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /devices/1/edit
  def edit
  end

  # POST /devices
  # POST /devices.xml
  def create
    respond_to do |format|
      if @device.save
        format.html { redirect_to(@device, :notice => 'Device was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /devices/1
  # PUT /devices/1.xml
  def update
    respond_to do |format|
      if @device.update_attributes(params[:device])
        format.html { redirect_to(@device, :notice => 'Device was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /devices/1
  # DELETE /devices/1.xml
  def destroy
    @device.destroy

    respond_to do |format|
      format.html { redirect_to(devices_url) }
    end
  end
end

