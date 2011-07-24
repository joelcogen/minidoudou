class BaseRomsController < ApplicationController
  before_filter :load_ressource, :except => [:new, :create]
  authorize_resource

  # GET /base_roms/1
  # GET /base_roms/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /base_roms/new
  # GET /base_roms/new.xml
  def new
    @device = Device.find(params[:device_id])
    @base_rom = @device.base_roms.build
    @base_rom.dev = true

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /base_roms/1/edit
  def edit
    @device = Device.find(params[:device_id])
  end

  # POST /base_roms
  # POST /base_roms.xml
  def create
    @device = Device.find(params[:device_id])
    @base_rom = BaseRom.new(params[:base_rom])
    @base_rom.uploader = current_user

    # Save file
    file_path = DataFile.store(params[:upload])
    unless file_path
      @base_rom.errors.add :file, 'upload failed, please try again'
      render :action => "new"
      return
    end
    @base_rom.file_path = file_path

    respond_to do |format|
      if @base_rom.save
        @base_rom.find_apks
        format.html { redirect_to([@device, @base_rom], :notice => 'Base rom was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /base_roms/1
  # PUT /base_roms/1.xml
  def update
    @device = Device.find(params[:device_id])

    # Save file
    if params[:upload]
      file_path = DataFile.store(params[:upload])
      unless file_path
        @base_rom.errors.add :file, 'upload failed, please try again'
        render :action => "new"
        return
      end
      @base_rom.file_path = file_path
      # Refresh APKs
      @base_rom.apks.each &:delete
      @base_rom.find_apks
    end

    respond_to do |format|
      if @base_rom.update_attributes(params[:base_rom])
        format.html { redirect_to([@device, @base_rom], :notice => 'Base rom was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /base_roms/1
  # DELETE /base_roms/1.xml
  def destroy
    @device = Device.find(params[:device_id])
    @base_rom.destroy

    respond_to do |format|
      format.html { redirect_to(@device) }
    end
  end

  def purge_configs
    if @base_rom.configurations.each &:destroy
      redirect_to([@base_rom.device, @base_rom], :notice => 'Purged.')
    else
      redirect_to([@base_rom.device, @base_rom], :notice => 'An error prevented the purge.')
    end
  end

  def purge_test_configs
    if @base_rom.configurations.select{|c| c.name.start_with? '_'}.each &:destroy
      redirect_to([@base_rom.device, @base_rom], :notice => 'Purged (test).')
    else
      redirect_to([@base_rom.device, @base_rom], :notice => 'An error prevented the purge.')
    end
  end
  
protected
  
  def load_ressource
    @base_rom = BaseRom.find(params[:base_rom_id] ? params[:base_rom_id] : params[:id])
  end
end

