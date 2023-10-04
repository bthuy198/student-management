module Manager
  class TeachersController < UsersController
    before_action :set_teacher, only: %i[show edit update destroy]

    # GET /teachers or /teachers.json
    def index
      @teachers = Teacher.all
      respond_to do |format|
        format.html
        format.js
        format.json { render json: @teachers }
      end
    end

    # GET /teachers/1 or /teachers/1.json
    def show
      @teacher = Teacher.find(params[:id])
      respond_to do |format|
        format.json { render json: @teacher }
      end
    end

    def new
      @teacher = Teacher.new
      respond_to do |format|
        format.html
        format.js
      end
    end

    # GET /teachers/1/edit
    def edit
      @teacher = Teacher.find(params[:id])
      respond_to do |format|
        format.html
        format.js
        format.json { render json: @teacher }
      end
    end

    # POST /teachers or /teachers.json
    def create
      @teacher = Teacher.create(teacher_params)

      respond_to do |format|
        if @teacher.save
          format.json { render json: @teacher }
        else
          format.html { render :index }
          #   format.html { render :new, status: :unprocessable_entity }
          #   format.json { render json: @teacher.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /teachers/1 or /teachers/1.json
    def update
      respond_to do |format|
        if @teacher.update(teacher_params)
          format.json { render json: @teacher }
        else
          format.html { render :index }
        end
      end
    end

    # DELETE /teachers/1 or /teachers/1.json
    def destroy
      @teacher = Teacher.find(params[:id])
      @teacher.destroy

      respond_to do |format|
        format.html { redirect_to manager_teachers_url }
        format.json { head :no_content }
        format.js   { render layout: false }
      end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_teacher
      @teacher = Teacher.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def teacher_params
      params.require(:teacher).permit(:name)
    end
  end
end
