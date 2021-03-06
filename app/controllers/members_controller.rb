class MembersController < ApplicationController
  def new
    @team_member = TeamMember.new
    @employee = Employee.all
    @team_id = params[:team_id]
  end

  def addemp
  	exists = TeamMember.find_by member_id: params[:member_id], team_id: params[:team_id]
  	if exists.nil?
      @team_member = TeamMember.new
      @team_member.team_id = params[:team_id]
      @team_member.member_id = params[:member_id]    
      @team_member.save
      redirect_to teams_url
    else
      session[:err_msg] = "Member already added"
      redirect_to "/members/new/#{params[:team_id]}"
    end
  end
  def drop
  	member_id = params[:member_id]
  	TeamMember.where("member_id =#{member_id} AND team_id = #{params[:team_id]}").delete_all
  	redirect_to teams_url
  end

  def show

  end

  def authenticate
    valid = Employee.find_by username: params[:username], password: params[:password]

    if valid != nil
      session[:username] = params[:username]
      session[:position] = valid.position
      redirect_to root_url
      # "/members/view"
    else
      redirect_to root_url
    end
  end

  def logout
     session[:username] = nil
     session[:position] = nil
     redirect_to members_url
  end

  def signup
    @employee = Employee.new
  end

  def addtoemployee
    exists = Employee.find_by username: params[:username]
    if exists.nil?
      @employee = Employee.new
      @employee.username = params[:username]
      @employee.password = params[:password]
      @employee.position = params[:position]
      @employee.first_name = params[:first_name]
      @employee.last_name = params[:last_name]
      @employee.contact_info = params[:contact_info]
      @employee.additional_info = params[:additional_info]
      @employee.pay_scale = params[:pay_scale]
      @employee.comments = params[:comments]

      if @employee.save
        redirect_to root_url
      else
        session[:err_msg] = "Member already added"
        redirect_to "/members/signup"
      end
    else
      session[:err_msg] = "Member already Existing"
      redirect_to "/members/signup"
    end
  end

  # def ajaxchk
  #   @teams = Team.find(1)
  #   puts "teams =#{@teams.inspect}"
  #   respond_to do |format|
  #     format.html # renders ajaxchk.html.erb
  #     format.js   # renders ajaxchk.js.erb
  #   end
  # end

  # def hello
  # #### your code goes here #####
  # @teams = Team.find(1)
  # respond_to do |format|
  #   format.js { render :layout=>false }
  # end
# end
end
