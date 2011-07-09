class ApksController < ApplicationController
  before_filter :authenticate_admin!, :except => [:index, :show]
  before_filter :authenticate_user!, :only => [:index, :show]

  # GET /apks
  # GET /apks.xml
  def index
    @apks = Apk.all.select {|a| a.base_rom.nil?}

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /apks/1
  # GET /apks/1.xml
  def show
    @apk = Apk.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /apks/new
  # GET /apks/new.xml
  def new
    @apk = Apk.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /apks/1/edit
  def edit
    @apk = Apk.find(params[:id])
  end

  # POST /apks
  # POST /apks.xml
  def create
    @apk = Apk.new(params[:apk])

    # Save file
    file_path = DataFile.store(params[:upload])
    unless file_path
      @apk.errors.add :file, 'upload failed, please try again'
      render :action => "new"
      return
    end
    @apk.location = file_path

    respond_to do |format|
      if @apk.save
        format.html { redirect_to(@apk, :notice => 'Apk was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /apks/1
  # PUT /apks/1.xml
  def update
    @apk = Apk.find(params[:id])

    # Save file
    if params[:upload]
      file_path = DataFile.store(params[:upload])
      unless file_path
        @apk.errors.add :file, 'upload failed, please try again'
        render :action => "new"
        return
      end
      @apk.file_path = file_path
    end

    respond_to do |format|
      if @apk.update_attributes(params[:apk])
        format.html { redirect_to(@apk, :notice => 'Apk was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /apks/1
  # DELETE /apks/1.xml
  def destroy
    @apk = Apk.find(params[:id])
    @apk.destroy

    respond_to do |format|
      format.html { redirect_to(apks_url) }
    end
  end
end

