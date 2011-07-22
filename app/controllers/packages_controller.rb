class PackagesController < ApplicationController
  load_and_authorize_resource

  # GET /packages
  # GET /packages.xml
  def index
    @packages = @packages.sort_by {|p| p.name}
    @current_packages = @packages.select {|p| !p.old}
    @old_packages = @packages.select {|p| p.old}

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /packages/1
  # GET /packages/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /packages/new
  # GET /packages/new.xml
  def new
    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /packages/1/edit
  def edit
  end

  # POST /packages
  # POST /packages.xml
  def create
    # Save file
    file_path = DataFile.store(params[:upload])
    unless file_path
      @package.errors.add :file, 'upload failed, please try again'
      render :action => "new"
      return
    end
    @package.file_path = file_path

    respond_to do |format|
      if @package.save
        format.html { redirect_to(@package, :notice => 'Package was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /packages/1
  # PUT /packages/1.xml
  def update
    # Save file
    if params[:upload]
      file_path = DataFile.store(params[:upload])
      unless file_path
        @package.errors.add :file, 'upload failed, please try again'
        render :action => "new"
        return
      end
      @package.file_path = file_path
    end

    respond_to do |format|
      if @package.update_attributes(params[:package])
        format.html { redirect_to(@package, :notice => 'Package was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  # DELETE /packages/1
  # DELETE /packages/1.xml
  def destroy
    if current_user.admin
      @package.destroy
    else
      @package.old = true
      @package.save
    end

    respond_to do |format|
      format.html { redirect_to(packages_url) }
    end
  end
end

