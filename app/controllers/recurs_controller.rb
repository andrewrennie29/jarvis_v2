class RecursController < ApplicationController
  before_action :set_recur, only: [:show, :edit, :update, :destroy]

  # GET /recurs
  # GET /recurs.json
  def index
    @recurs = Recur.all
  end

  # GET /recurs/1
  # GET /recurs/1.json
  def show
  end

  # GET /recurs/new
  def new
    @recur = Recur.new
  end

  # GET /recurs/1/edit
  def edit
  end

  # POST /recurs
  # POST /recurs.json
  def create
    @recur = Recur.new(recur_params)

    respond_to do |format|
      if @recur.save
        format.html { redirect_to @recur, notice: 'Recur was successfully created.' }
        format.json { render :show, status: :created, location: @recur }
      else
        format.html { render :new }
        format.json { render json: @recur.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recurs/1
  # PATCH/PUT /recurs/1.json
  def update
    respond_to do |format|
      if @recur.update(recur_params)
        format.html { redirect_to @recur, notice: 'Recur was successfully updated.' }
        format.json { render :show, status: :ok, location: @recur }
      else
        format.html { render :edit }
        format.json { render json: @recur.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recurs/1
  # DELETE /recurs/1.json
  def destroy
    @recur.destroy
    respond_to do |format|
      format.html { redirect_to recurs_url, notice: 'Recur was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recur
      @recur = Recur.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def recur_params
      params.require(:recur).permit(:recurs, :frequency, :daypattern, :enddate, :latestdate, :nextdate, :todo_id)
    end
end
