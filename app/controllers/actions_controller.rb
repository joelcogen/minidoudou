class ActionsController < ApplicationController
  # GET /actions
  # GET /actions.xml
  def index
    @actions = Action.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @actions }
    end
  end

  # GET /actions/1
  # GET /actions/1.xml
  def show
    @action = Action.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @action }
    end
  end

  # GET /actions/new
  # GET /actions/new.xml
  def new
    @action = Action.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @action }
    end
  end

  # GET /actions/1/edit
  def edit
    @action = Action.find(params[:id])
  end

  # POST /actions
  # POST /actions.xml
  def create
    @action = Action.new(params[:action])

    respond_to do |format|
      if @action.save
        format.html { redirect_to(@action, :notice => 'Action was successfully created.') }
        format.xml  { render :xml => @action, :status => :created, :location => @action }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @action.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /actions/1
  # PUT /actions/1.xml
  def update
    @action = Action.find(params[:id])

    respond_to do |format|
      if @action.update_attributes(params[:action])
        format.html { redirect_to(@action, :notice => 'Action was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @action.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /actions/1
  # DELETE /actions/1.xml
  def destroy
    @action = Action.find(params[:id])
    @action.destroy

    respond_to do |format|
      format.html { redirect_to(actions_url) }
      format.xml  { head :ok }
    end
  end
end
