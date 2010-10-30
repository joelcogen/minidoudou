class PackagesController < ApplicationController
  # GET /packages
  # GET /packages.xml
  def index
    @packages = Package.all
    @current_packages = @packages.select {|p| !p.old}
    @old_packages = @packages.select {|p| p.old}

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /packages/1
  # GET /packages/1.xml
  def show
    @package = Package.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /packages/new
  # GET /packages/new.xml
  def new
    @package = Package.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /packages/1/edit
  def edit
    @package = Package.find(params[:id])
  end

  # POST /packages
  # POST /packages.xml
  def create
    @package = Package.new(params[:package])

    # Save file
    file_path = DataFile.store(params[:upload])
    unless file_path
      flash[:error] = 'Upload failed, please try again'
      redirect_to :action => "new"
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
    @package = Package.find(params[:id])

    # Save file
    file_path = DataFile.store(params[:upload])
    unless file_path
      flash[:error] = 'Upload failed, please try again'
      redirect_to :action => "new"
      return
    end
    @package.file_path = file_path

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
    @package = Package.find(params[:id])
    @package.destroy

    respond_to do |format|
      format.html { redirect_to(packages_url) }
    end
  end
end

