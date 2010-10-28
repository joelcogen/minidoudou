class BaseRomsController < ApplicationController
  # GET /base_roms
  # GET /base_roms.xml
  def index
    @base_roms = BaseRom.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @base_roms }
    end
  end

  # GET /base_roms/1
  # GET /base_roms/1.xml
  def show
    @base_rom = BaseRom.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @base_rom }
    end
  end

  # GET /base_roms/new
  # GET /base_roms/new.xml
  def new
    @base_rom = BaseRom.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @base_rom }
    end
  end

  # GET /base_roms/1/edit
  def edit
    @base_rom = BaseRom.find(params[:id])
  end

  # POST /base_roms
  # POST /base_roms.xml
  def create
    @base_rom = BaseRom.new(params[:base_rom])

    respond_to do |format|
      if @base_rom.save
        format.html { redirect_to(@base_rom, :notice => 'Base rom was successfully created.') }
        format.xml  { render :xml => @base_rom, :status => :created, :location => @base_rom }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @base_rom.errors, :status => :unprocessable_entity }
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
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @base_rom.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /base_roms/1
  # DELETE /base_roms/1.xml
  def destroy
    @base_rom = BaseRom.find(params[:id])
    @base_rom.destroy

    respond_to do |format|
      format.html { redirect_to(base_roms_url) }
      format.xml  { head :ok }
    end
  end
end
