class StudentsController < ApplicationController
  def index
    @students = Student.all
  end

  def show
    @student = Student.find(params[:id])
    if @student.present?
      flash[:success] = "Created success!"
    else
      render :text => 'Not Found', :status => :not_found
    end
  end

  def new
    @student = Student.new
    @student.grades.build
    # @student.grades.build unless @student.grades.build.present?
  end

  def create
    @student = Student.new student_params
    puts @student
    if @student.save
      flash[:success] = "Created success!"
      redirect_to root_path 
    else
      flash[:error] = "Created failed!"
      render :new
    end
  end

  def update
    @student = Student.find(params[:id])
    if @student.update(params.require(:student).permit(:name, :phone, :address))
      flash[:success] = "Student successfully updated!"
      redirect_to student_url(@student)
    else
      flash.now[:error] = "To-do item update failed"
      render :edit
    end
  end

  def edit
    @student = Student.find(params[:id])
    render :edit
  end

  def destroy
    @student = Student.find(params[:id])
    @student.destroy
    flash[:success] = "This student was successfully destroyed."
    redirect_to students_url
  end

  private
  def student_params
    params.require(:student).permit(:name, :phone, :address, grades_attributes: [:subject, :score, :semester, :comments])
  end
end
