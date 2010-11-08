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
      format.xml  { render :xml => @configuration }
    end
  end

  # GET /configurations/new
  # GET /configurations/new.xml
  def new
    @base_rom = BaseRom.find(params[:base_rom_id])
    @configuration = @base_rom.configurations.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /configurations/1/edit
  def edit
    @configuration = Configuration.find(params[:id])
  end

  # POST /configurations
  # POST /configurations.xml
  def create
    @base_rom = BaseRom.find(params[:base_rom_id])
    @configuration = Configuration.new(params[:configuration])
    @configuration.base_rom = @base_rom

    packages = params[:packages]
    packages.each do |package|
      package_id = package.first
      package_selected = package.last
      next if package_selected != '1'

      package = Package.find(package_id)
      @configuration.packages << package
    end

    respond_to do |format|
      if @configuration.save
        format.html { redirect_to(device_base_rom_configurations_path(@base_rom.device, @base_rom), :notice => 'Your configuration was successfully created. It should be ready for download in about 5 minutes.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /configurations/1
  # PUT /configurations/1.xml
  def update
    @configuration = Configuration.find(params[:id])

    respond_to do |format|
      if @configuration.update_attributes(params[:configuration])
        format.html { redirect_to(@configuration, :notice => 'Configuration was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @configuration.errors, :status => :unprocessable_entity }
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
      format.xml  { head :ok }
    end
  end
end

