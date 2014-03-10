class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :edit, :update, :destroy]

  # GET /teams
  # GET /teams.json
  def index
    @teams = Team.all
    emp_data = {}
    @new_arr =[]
    @teams.each do |team|
      all_data = Employee.find_by_sql("select employees.id,employees.username,employees.last_name,team_members.team_id,team_members.member_id from employees,team_members where team_members.team_id=#{team.id} and team_members.member_id=employees.id")
      i=0
      if all_data != nil
        i = 0
        k = team.id
        @new_arr[k] = []
        # puts "team-id, k= #{k}"
        all_data.each do |data|
          if team.id !=nil
            @new_arr[k][i]=[data['username'],data['id']]
          end
          i = i+1
        end
      end     
    end
    @team = Team.new
  end

  # GET /teams/1
  # GET /teams/1.json
  def show
  end

  # GET /teams/new
  def new
    @team = Team.new
  end

  # GET /teams/1/edit
  def edit
  end

  # POST /teams
  # POST /teams.json
  def create
    @team = Team.new(team_params)

    respond_to do |format|
      if @team.save
        # render :nothing => true
        format.html { redirect_to teams_path, notice: '' }
        format.json { render action: 'index', status: :created }
      else
        # render :text => @team.errors, :status => :unprocessable_entity
        format.html { render action: 'new' }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /teams/1
  # PATCH/PUT /teams/1.json
  def update
    respond_to do |format|
      if @team.update(team_params)
        format.html { redirect_to teams_path, notice: '' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teams/1
  # DELETE /teams/1.json
  def destroy
    @team.destroy
    respond_to do |format|
      format.html { redirect_to teams_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_team
      @team = Team.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def team_params
      params.require(:team).permit(:team_name, :team_lead)
    end
end
