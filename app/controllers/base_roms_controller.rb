class BaseRomsController < ApplicationController
  # GET /base_roms
  # GET /base_roms.xml
  def index
    @base_roms = BaseRom.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /base_roms/1
  # GET /base_roms/1.xml
  def show
    @base_rom = BaseRom.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /base_roms/new
  # GET /base_roms/new.xml
  def new
    @device = Device.find(params[:device_id])
    @base_rom = @device.base_roms.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /base_roms/1/edit
  def edit
    @base_rom = BaseRom.find(params[:id])
    @device = Device.find(params[:device_id])
  end

  # POST /base_roms
  # POST /base_roms.xml
  def create
    @device = Device.find(params[:device_id])
    @base_rom = BaseRom.new(params[:base_rom])

    respond_to do |format|
      if @device.base_roms << @base_rom
        format.html { redirect_to([@device, @base_rom], :notice => 'Base rom was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /base_roms/1
  # PUT /base_roms/1.xml
  def update
    @base_rom = BaseRom.find(params[:id])

    respond_to do |format|
      if @base_rom.update_attributes(params[:base_rom])
        format.html { redirect_to(@base_rom, :notice => 'Base rom was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /base_roms/1
  # DELETE /base_roms/1.xml
  def destroy
    @base_rom = BaseRom.find(params[:id])
    @device = Device.find(params[:device_id])
    @base_rom.destroy

    respond_to do |format|
      format.html { redirect_to(@device) }
    end
  end
end

