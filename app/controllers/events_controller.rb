class EventsController < ApplicationController
  
  def new
    @event = Event.new(:endtime => 1.hour.from_now, :period => "Does not repeat")
    @teams = Team.all
    render :json => {:form => render_to_string(:partial => 'form')}
  end
  
  def create
    if params[:event][:period] == "Does not repeat"
      event = Event.new(event_params)
    else
      #      @event_series = EventSeries.new(:frequency => params[:event][:frequency], :period => params[:event][:repeats], :starttime => params[:event][:starttime], :endtime => params[:event][:endtime], :all_day => params[:event][:all_day])
      event = EventSeries.new(event_params)
    end
    if event.save
      render :nothing => true
    else
      render :text => event.errors.full_messages.to_sentence, :status => 422
    end
  end
  
  def index
    if session[:username].nil?
      redirect_to members_url
    end
    @teams = Team.all
    # @areas = Area.all
    @row_data = Event.where('month(endtime)=month(now())').uniq.pluck(:area_code)
    if @row_data != nil
      area_codes = @row_data.join(",").gsub(",","','")
      # puts area_codes.inspect
      @area_day_wise = Area.where("areacode in ('#{area_codes}')")
    end
    @hash = Gmaps4rails.build_markers(@area_day_wise) do |area, marker|
      marker.lat area.latitude
      marker.lng area.longitude
      marker.infowindow area.description
    end
  end
  
  
  def get_events
    events = []
    if params[:empId] == "all" || params[:empId] == ""
      @events = Event.find(:all, :conditions => ["starttime >= '#{Time.at(params['start'].to_i).to_formatted_s(:db)}' and endtime <= '#{Time.at(params['end'].to_i).to_formatted_s(:db)}'"] )
      # @events.each do |event|
      #   events << {:id => event.id, :title => event.title, :description => event.description || "Some cool description here...", :start => "#{event.starttime.iso8601}", :end => "#{event.endtime.iso8601}", :allDay => event.all_day, :recurring => (event.event_series_id)? true: false}
      # end
    else
      @events = Event.where('team_lead in (?)',params[:empId])
    end
    @events.each do |event|
      team = Team.find_by_id event.team_lead
      theme = (team ? team.theme : 'label-yellow')
      events << {:id => event.id, :theme => theme , :title => event.title, :description => event.description || "Some cool description here...", :start => "#{event.starttime.iso8601}", :end => "#{event.endtime.iso8601}", :allDay => event.all_day, :recurring => (event.event_series_id)? true: false}
    end         
    render :text => events.to_json
  end
  
  
  
  def move
    @event = Event.find_by_id params[:id]
    if @event
      @event.starttime = (params[:minute_delta].to_i).minutes.from_now((params[:day_delta].to_i).days.from_now(@event.starttime))
      @event.endtime = (params[:minute_delta].to_i).minutes.from_now((params[:day_delta].to_i).days.from_now(@event.endtime))
      @event.all_day = params[:all_day]
      @event.save
    end
    render :nothing => true
  end
  
  
  def resize
    @event = Event.find_by_id params[:id]
    if @event
      @event.endtime = (params[:minute_delta].to_i).minutes.from_now((params[:day_delta].to_i).days.from_now(@event.endtime))
      @event.save
    end    
    render :nothing => true
  end
  
  def edit
    @event = Event.find_by_id(params[:id])
    render :json => { :form => render_to_string(:partial => 'edit_form') } 
  end
  
  def update
    @event = Event.find_by_id(params[:event][:id])
    if params[:event][:commit_button] == "Update All Occurrence"
      @events = @event.event_series.events #.find(:all, :conditions => ["starttime > '#{@event.starttime.to_formatted_s(:db)}' "])
      @event.update_events(@events, event_params)
    elsif params[:event][:commit_button] == "Update All Following Occurrence"
      @events = @event.event_series.events.find(:all, :conditions => ["starttime > '#{@event.starttime.to_formatted_s(:db)}' "])
      @event.update_events(@events, event_params)
    else
      @event.attributes = event_params
      @event.save
    end
    render :nothing => true    
  end  
  
  def destroy
    @event = Event.find_by_id(params[:id])
    if params[:delete_all] == 'true'
      @event.event_series.destroy
    elsif params[:delete_all] == 'future'
      @events = @event.event_series.events.find(:all, :conditions => ["starttime > '#{@event.starttime.to_formatted_s(:db)}' "])
      @event.event_series.events.delete(@events)
    else
      @event.destroy
    end
    render :nothing => true   
  end

  private
    def event_params
      # params.require(:event).permit('area_code','team_lead','home_details','title', 'description', 'starttime(1i)', 'starttime(2i)', 'starttime(3i)', 'starttime(4i)', 'starttime(5i)', 'endtime(1i)', 'endtime(2i)', 'endtime(3i)', 'endtime(4i)', 'endtime(5i)', 'commit_button')
      params.require(:event).permit('area_code','team_lead','home_details','title', 'description', 'starttime(1i)', 'starttime(2i)', 'starttime(3i)', 'starttime(4i)', 'starttime(5i)', 'endtime(1i)', 'endtime(2i)', 'endtime(3i)', 'endtime(4i)', 'endtime(5i)', 'all_day', 'period', 'frequency', 'commit_button')
    end
  
end
