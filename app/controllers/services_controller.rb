class ServicesController < ApplicationController
  # GET /services
  # GET /services.json
  def index
    redirect_to host_path(params[:host_id])
=begin
    @services = Service.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @services }
    end
=end
  end

  # GET /services/1
  # GET /services/1.json
  def show
    if params[:hostname]
      @host = Host.find_by_hostname(params[:hostname])
      unless @host
        @host = Host.new
        @host.hostname = params[:hostname]
        @host.save
      end
      @service = @host.services.find_by_service_check(params[:service_check])
      unless @service
        @service = Service.new
        @service.service_check = params[:service_check]
        @service.host_id = @host.id
        @service.save
      end
    elsif params[:host_id]
      @host = Host.find(params[:host_id])
      @service = @host.services.find(params[:id])
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @service }
    end
  end

  # GET /services/new
  # GET /services/new.json
  def new
    @service = Service.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @service }
    end
  end

  # GET /services/1/edit
  def edit
    if params[:hostname]
    @host = Host.find_by_hostname(params[:hostname])
    unless @host
      @host = Host.new
      @host.hostname = params[:hostname]
      @host.save
    end
    @service = @host.services.find_by_service_check(params[:service_check])
    unless @service
      @service = Service.new
      @service.service_check = params[:service_check]
      @service.host_id = @host.id
      @service.save
    end
    elsif params[:host_id]
      @host = Host.find(params[:host_id])
      @service = @host.services.find(params[:id])
    end
    #@service = Service.find(params[:id])
  end

  # POST /services
  # POST /services.json
  def create
    @host = Host.find(params[:host_id])
    @service = @host.services.create(params[:service])
    redirect_to host_path(@host)
    #@service = Service.new(params[:service])

=begin
    respond_to do |format|
      if @service.save
        format.html { redirect_to @service, :notice => 'Service was successfully created.' }
        format.json { render :json => @service, :status => :created, :location => @service }
      else
        format.html { render :action => "new" }
        format.json { render :json => @service.errors, :status => :unprocessable_entity }
      end
    end
=end
  end

  # PUT /services/1
  # PUT /services/1.json
  def update
    if params[:hostname]
      @host = Host.find_by_hostname(params[:hostname])
      unless @host
        @host = Host.new
        @host.hostname = params[:hostname]
        @host.save
      end
      @service = @host.services.find_by_service_check(params[:service_check])
      unless @service
        @service = Service.new
        @service.service_check = params[:service_check]
        @service.host_id = @host.id
      end
      @service.notes = params[:notes]
      @service.save
      redirect_to host_service_path(@host, @service), :notice => 'Service was successfully updated.'
    elsif params[:host_id]
      @service = Service.find(params[:id])

      respond_to do |format|
        if @service.update_attributes(params[:service])
          format.html { redirect_to host_service_path(@service.host, @service), :notice => 'Service was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render :action => "edit" }
          format.json { render :json => @service.errors, :status => :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /services/1
  # DELETE /services/1.json
  def destroy
    @service = Service.find(params[:id])
    @service.destroy

    respond_to do |format|
      format.html { redirect_to services_url }
      format.json { head :no_content }
    end
  end
end
