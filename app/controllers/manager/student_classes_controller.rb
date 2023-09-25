module Manager
  class StudentClassesController < UsersController
    # before_action :set_student_class, only: %i[show edit update destroy]

    # GET /student_classes or /student_classes.json
    def index
      @student_classes = StudentClass.all
      respond_to do |format|
        format.html
        format.js
        format.json { render json: @student_classes }
      end
    end

    # GET /student_classes/1 or /student_classes/1.json
    def show
      @student_class = StudentClass.find(params[:id])
      respond_to do |format|
        format.json { render json: @student_class }
      end
    end

    # GET /student_classes/new
    def new
      @student_class = StudentClass.new
      respond_to do |format|
        format.html
        format.js
      end
    end

    # GET /student_classes/1/edit
    def edit
      @student_class = Teacher.find(params[:id])
      respond_to do |format|
        format.html
        format.js
        format.json { render json: @student_class }
      end
    end

    # POST /student_classes or /student_classes.json
    def create
      @student_class = StudentClass.new(student_class_params)

      respond_to do |format|
        if @student_class.save
          format.json { render json: @student_class }
        else
          format.html { render :index }
        end
      end
    end

    # PATCH/PUT /student_classes/1 or /student_classes/1.json
    def update
      respond_to do |format|
        if @student_class.update(teacher_params)
          format.json { render json: @student_class }
        else
          format.html { render :index }
        end
      end
    end

    # DELETE /student_classes/1 or /student_classes/1.json
    def destroy
      @student_class = Teacher.find(params[:id])
      @student_class.destroy

      respond_to do |format|
        format.html { redirect_to manager_teachers_url }
        format.json { head :no_content }
        format.js   { render layout: false }
      end
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_student_class
      @student_class = StudentClass.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def student_class_params
      params.require(:student_class).permit(:name)
    end
  end
end
