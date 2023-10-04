class SchoolsController < ApplicationController
  before_action :set_school, only: %i[show edit update destroy]

  # GET /schools or /schools.json
  def index
    q = params[:q]
    id = params[:id_eq]
    if params[:id_eq]
      @teachers = Teacher.ransack(q).result.where(school_id: id)
      @student_classes = StudentClass.ransack(q).result.where(school_id: id)
    else
      @teachers = Teacher.ransack(q).result
      @student_classes = StudentClass.ransack(q).result
    end
    @schools = School.all
    # @q = School.all.joins(:student_classes, :teachers).ransack(params[:q])
    # @schools = @q.result
    # @student_classes = StudentClass.all
    # @teachers = Teacher.search(name_cont: q).result
    # @student_classes = StudentClass.search(name_cont: q).result
    # @classes = StudentClass.search(name_cont: q).result
    # @teachers = Teacher.ransack(@q).result(distinct: true)
    # @student_classes = StudentClass.search(name_cont: @q).result
    # @q = School.ransack(params[:q])
    # @schools = @q.result.includes(:teachers, :student_classes)
  end

  def search
    q = params[:q]
    id = param[:id]
    @teachers.where(category_id: params[:category_id]) if params[:category_id].present?
    if param[:id]
      @teachers = Teacher.ransack(q).result.where(school_id: id)
      @student_classes = StudentClass.ransack(q).result.where(school_id: id)
    else
      @teachers = Teacher.ransack(q).result
      @student_classes = StudentClass.ransack(q).result
    end
    @schools = School.all
  end

  # GET /schools/1 or /schools/1.json
  def show; end

  # GET /schools/new
  def new
    @school = School.new
  end

  # GET /schools/1/edit
  def edit; end

  # POST /schools or /schools.json
  def create
    @school = School.new(school_params)

    respond_to do |format|
      if @school.save
        format.html { redirect_to school_url(@school), notice: 'School was successfully created.' }
        format.json { render :show, status: :created, location: @school }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @school.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /schools/1 or /schools/1.json
  def update
    respond_to do |format|
      if @school.update(school_params)
        format.html { redirect_to school_url(@school), notice: 'School was successfully updated.' }
        format.json { render :show, status: :ok, location: @school }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @school.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /schools/1 or /schools/1.json
  def destroy
    @school.destroy

    respond_to do |format|
      format.html { redirect_to schools_url, notice: 'School was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_school
    @school = School.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def school_params
    params.require(:school).permit(:name)
  end

  def search_params
    params.require(:school).permit(:id)
  end
end
