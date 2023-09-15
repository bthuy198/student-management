# frozen_string_literal: true

module Manager
  # student controller class
  class StudentsController < ApplicationController
    def index
      @students = @students = if params[:key]
                                Student.where('name like ?', "%#{params[:key]}%").all.page params[:page]
                              else
                                Student.all.page params[:page]
                              end
      # current_page = params[:page].to_f.ceil || 1
      # start = @@result_per_page * (current_page - 1)
      # @students = Student.search_by_name(params[:key]).offset(start).limit(current_page)
    end

    def search_params
      params.permit(:key, :page)
    end

    def show
      @student = Student.find(params[:id])
      if @student.present?
        flash[:success] = 'Created success!'
      else
        render text: 'Not Found', status: :not_found
      end
    end

    def new
      @student = Student.new
      @student.grades.build
      @student.avatar = params[:file]
    end

    def create
      @student = Student.new student_params
      puts @student
      if @student.save
        flash[:success] = 'Created success!'
        redirect_to manager_root_path
      else
        # flash[:error] = 'Created failed!'
        render :new
      end
    end

    def update
      @student = Student.find(params[:id])
      @grade = Grade.find_by(student_id: params[:id])
      respond_to do |format|
        if @student.update(update_params)
          format.html { redirect_to edit_manager_student_url(@student), notice: 'Student was successfully updated.' }
          format.json { render :edit, status: :ok, location: @student }
        else
          format.html { render :edit }
          format.json { render json: @student.errors, status: :unprocessable_entity }
        end
      end
      # @student = Student.find(params[:id])
      # if @student.update student_params
      #   flash[:success] = "Student successfully updated!"
      #   redirect_to(@student)
      # else
      #   flash.now[:error] = "To-do item update failed"
      #   render :edit
      # end
    end

    def edit
      @student = Student.find(params[:id])
      # @student.grades = Grade.find_by student_id: @student.id
      render :edit
    end

    def destroy
      @student = Student.find(params[:id])
      @student.destroy
      flash[:success] = 'This student was successfully destroyed.'
      redirect_to manager_students_url
    end

    def preview
      @student = Student.find(params[:id]).to_json
    end

    private

    def student_params
      params.require(:student).permit(:name, :phone, :address, :avatar, :video, :audio,
                                      grades_attributes: %i[subject score semester comments _destroy])
    end

    def update_params
      params.require(:student).permit(:name, :phone, :address, :avatar, :video, :audio,
                                      grades_attributes: %i[subject score semester comments])
    end
  end
end
