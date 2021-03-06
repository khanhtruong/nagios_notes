class HostsController < ApplicationController
  # GET /hosts
  # GET /hosts.json
  def index
    @hosts = Host.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @hosts }
    end
  end

  # GET /hosts/1
  # GET /hosts/1.json
  def show
    if params[:id]
      @host = Host.find(params[:id])
    elsif params[:hostname]
      @host = Host.find_by_hostname(params[:hostname])
      unless @host
        @host = Host.new
        @host.hostname = params[:hostname]
        @host.save
      end
    end
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @host }
    end
  end

  # GET /hosts/new
  # GET /hosts/new.json
  def new
    @host = Host.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @host }
    end
  end

  # GET /hosts/1/edit
  def edit
    if params[:hostname]
      @host = Host.find_by_hostname(params[:hostname])
      unless @host
        @host = Host.new
        @host.hostname = params[:hostname]
        @host.save
      end
    elsif params[:id]
        @host = Host.find(params[:id])
    end
  end

  # POST /hosts
  # POST /hosts.json
  def create
    @host = Host.new(params[:host])

    respond_to do |format|
      if @host.save
        format.html { redirect_to @host, :notice => 'Host was successfully created.' }
        format.json { render :json => @host, :status => :created, :location => @host }
      else
        format.html { render :action => "new" }
        format.json { render :json => @host.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /hosts/1
  # PUT /hosts/1.json
  def update
    if params[:hostname]
      @host = Host.find_by_hostname(params[:hostname])
      unless @host
        @host = Host.new
        @host.hostname = params[:hostname]
      end
      if params[:ip] then @host.ip = params[:ip] end
      if params[:notes] then @host.notes = params[:notes] end
      @host.save
      redirect_to @host, :notice => 'Host was successfully updated.'
    elsif params[:id]
      @host = Host.find(params[:id])

      respond_to do |format|
        if @host.update_attributes(params[:host])
          format.html { redirect_to @host, :notice => 'Host was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render :action => "edit" }
          format.json { render :json => @host.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /hosts/1
  # DELETE /hosts/1.json
  def destroy
    @host = Host.find(params[:id])
    @host.destroy

    respond_to do |format|
      format.html { redirect_to hosts_url }
      format.json { head :no_content }
    end
  end
end
