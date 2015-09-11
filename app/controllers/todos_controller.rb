class TodosController < ApplicationController
  before_action :set_todo, only: [:show, :edit, :update, :destroy]
  before_action :set_all_todos, only: [:index]
  
  # GET /todos
  # GET /todos.json
  def index
    @todo = Todo.new
    unless session[:user_id].nil?
      session[:active_project] = nil
    end
  end

  # GET /todos/1
  # GET /todos/1.json
  def show
  end

  # GET /todos/new
  def new
    @todo = Todo.new
    @recur = Recur.new
  end

  # GET /todos/1/edit
  def edit
  end

  # POST /todos
  # POST /todos.json
  def create
    @todo = Todo.new(todo_params)
    @todo.save

    if params["recur"]["recurs"] == "1"
      daypattern = Recur.createdaypattern(params["recur"]["daypattern"])
      @recur = Recur.new
      @recur.update(:recurs => params["recur"]["recurs"].to_i,
                    :daypattern => daypattern,
                    :frequency => params["recur"]["frequency"],
                    :enddate => params["recur"]["enddate"],
                    :todo_id => @todo.id)
    end

    @todos = User.find_by_id(session[:user_id]).todos.joins(:status).order('statuses.complete asc, todos.assigneddate asc, todos.duedate asc, todos.name asc')
    @projectstatus = Todo.statusobjects(user_id: session[:user_id])

    unless session[:active_project].nil?
      @project = Project.find_by_slug(session[:active_project])
    end
    #respond_to do |format|
    #  if @todo.save
    #    format.html { redirect_to '/' }
    #    format.json { render :show, status: :created, location: @todo }
    #  else
    #    format.html { render :new }
    #    format.json { render json: @todo.errors, status: :unprocessable_entity }
    #  end
    #end
  end

  # PATCH/PUT /todos/1
  # PATCH/PUT /todos/1.json
  def update
    @todo.update(todo_params)

    if params["recur"]["recurs"] == "1"
      if @todo.recur.nil?
        @recur = Recur.new
      else
        @recur = @todo.recur
      end
      daypattern = Recur.createdaypattern(params["recur"]["daypattern"])
      
      @recur.update(:recurs => params["recur"]["recurs"].to_i,
                    :daypattern => daypattern,
                    :frequency => params["recur"]["frequency"],
                    :enddate => params["recur"]["enddate"],
                    :todo_id => @todo.id)
    end

    @todos = User.find_by_id(session[:user_id]).todos.joins(:status).order('statuses.complete asc, todos.assigneddate asc, todos.duedate asc, todos.name asc')
    @projectstatus = Todo.statusobjects(user_id: session[:user_id])

    unless session[:active_project].nil?
      @project = Project.find_by_slug(session[:active_project])
    end

    #respond_to do |format|
    #  if @todo.update(todo_params)
    #    format.html { redirect_to '/', notice: 'Todo was successfully updated.' }
    #    format.json { render :show, status: :ok, location: @todo }
    #  else
    #    format.html { render :edit }
    #    format.json { render json: @todo.errors, status: :unprocessable_entity }
    #  end
    #end
  end

  # DELETE /todos/1
  # DELETE /todos/1.json
  def destroy
    @todo.destroy
    
    @todos = User.find_by_id(session[:user_id]).todos.joins(:status).order('statuses.complete asc, todos.assigneddate asc, todos.duedate asc, todos.name asc')
    @projectstatus = Todo.statusobjects(user_id: session[:user_id])

    unless session[:active_project].nil?
      @project = Project.find_by_slug(session[:active_project])
    end
    #respond_to do |format|
    #  format.html { redirect_to '/', notice: 'Todo was successfully destroyed.' }
    #  format.json { head :no_content }
    #end
  end

  def navbarnew
    
    if session[:active_project].nil?
      session[:active_project] = Project.find_by_name('No Project').slug
    end

    @todo = Todo.create(:name => params[:todo][:name], :project_id => Project.find_by_slug(session[:active_project]).id, :duedate => Date.today)
    unless @todo.valid?
      flash[:error] = @todo.errors.full_messages.join("<br>").html_safe
    else
      flash[:success] = "Todo added successfully"
    end

    session[:active_project] = nil

    redirect_to @todo, remote: true
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_todo
      @todo = Todo.find(params[:id])
      @recur = @todo.recur

      if @recur.nil?
        @recur = Recur.new
      end

    end

    def set_all_todos
      unless session[:user_id].nil?
        @todos = User.find_by_id(session[:user_id]).todos.joins(:status).order('statuses.complete asc, todos.assigneddate asc, todos.duedate asc, todos.name asc')
        @projectstatus = Todo.statusobjects(user_id: session[:user_id])
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def todo_params
      params[:todo].permit(:name, :details, :duedate, :project_id, :assigneddate, :category_id, :points, :importance)
    end
end
