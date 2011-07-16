class ApksController < ApplicationController
  before_filter :authenticate_user!
  before_filter :authenticate_uploader_or_admin!, :except => [:index, :show]

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
    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /apks/1/edit
  def edit
  end

  # POST /apks
  # POST /apks.xml
  def create
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
    @apk.destroy

    respond_to do |format|
      format.html { redirect_to(apks_url) }
    end
  end
  
protected

  def authenticate_uploader_or_admin!
    @apk = params[:id] ? Apk.find(params[:id]) : Apk.new
    admin_ok = @apk.base_rom.nil? && current_user.admin
    uploader_ok = @apk.base_rom.present? && current_user.owns_rom(@apk.base_rom)
    unless admin_ok || uploader_ok
      redirect_to(@apk, :notice => 'Only admins can modify extra APKs')
    end
  end
end

