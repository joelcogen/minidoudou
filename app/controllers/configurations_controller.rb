class ConfigurationsController < ApplicationController
  before_filter :authenticate, :except => [:index, :show, :new, :create]

  # GET /configurations
  # GET /configurations.xml
  def index
    @base_rom = BaseRom.find(params[:base_rom_id])
    @configurations = @base_rom.configurations.sort_by {|c| c.created_at}.reverse

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /configurations/1
  # GET /configurations/1.xml
  def show
    @configuration = Configuration.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /configurations/new
  # GET /configurations/new.xml
  def new
    @base_rom = BaseRom.find(params[:base_rom_id])
    @configuration = @base_rom.configurations.new
    @extra_apks = Apk.all.select {|a| a.base_rom.nil?}

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # POST /configurations
  # POST /configurations.xml
  def create
    @base_rom = BaseRom.find(params[:base_rom_id])
    @configuration = Configuration.new(params[:configuration])
    @configuration.base_rom = @base_rom

    # Add packages
    packages = params[:packages]
    packages.each do |package|
      package_id = package.first
      package_selected = package.last
      next if package_selected != '1'

      package = Package.find(package_id)
      @configuration.packages << package
    end

    # Compute APK changes
    changes = params[:apk]
    changes.each do |change|
      apk = Apk.find(change.first)
      destination = change.last

      next if apk.location == destination || (destination=='remove' && apk.base_rom.nil?)
      @configuration.changes << Change.new(:apk => apk, :destination => destination)
    end

    respond_to do |format|
      if @configuration.save
        format.html { redirect_to(device_base_rom_configurations_path(@base_rom.device, @base_rom), :notice => 'Your configuration was successfully created. It should be ready for download in about 5 minutes.') }
      else
        @extra_apks = Apk.all.select {|a| a.base_rom.nil?}
        format.html { render :action => "new" }
      end
    end
  end

  # DELETE /configurations/1
  # DELETE /configurations/1.xml
  def destroy
    @configuration = Configuration.find(params[:id])
    @configuration.destroy

    respond_to do |format|
      format.html { redirect_to(configurations_url) }
    end
  end
end

