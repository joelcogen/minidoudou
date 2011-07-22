class BaseRomPackagesController < ApplicationController
  before_filter :load_and_authorize_resource

  # GET /base_rom_packages/new
  # GET /base_rom_packages/new.xml
  def new
    @base_rom_package = @base_rom.base_rom_packages.build
    @packages = Package.all.select {|p| !@base_rom.packages.include? p}
    @current_packages = @packages.select {|p| !p.old}
    @old_packages = @packages.select {|p| p.old}
    @packages = @current_packages + [Package.new(:name=>'--- Deprecated packages ---')] + @old_packages

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # POST /base_rom_packages
  # POST /base_rom_packages.xml
  def create
    @device = Device.find(params[:device_id])
    @base_rom_package = BaseRomPackage.new(params[:base_rom_package])

    respond_to do |format|
      if @base_rom_package.save
        format.html { redirect_to([@device, @base_rom], :notice => 'Package added to Base ROM.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # DELETE /base_rom_packages/1
  # DELETE /base_rom_packages/1.xml
  def destroy
    @base_rom_package = BaseRomPackage.find(params[:id])
    @base_rom_package.destroy

    respond_to do |format|
      format.html { redirect_to([@base_rom.device, @base_rom]) }
    end
  end
  
protected

  def load_and_authorize_resource
    @base_rom = BaseRom.find(params[:base_rom_id])
    authorize! :manage, @base_rom
  end
end

