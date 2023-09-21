# frozen_string_literal: true

module Manager
  # student controller class
  class StudentsController < UsersController
    def index
      @q = Student.ransack(params[:q])
      @students = @q.result.page(params[:page])
      # @students = if params[:key]
      #               Student.without_deleted.where('concat(firstname, " ", lastname) like ?',
      #                                             "%#{params[:key]}%").or(Student.without_deleted.where('concat(lastname, " ", firstname) like ?',
      #                                                                                                   "%#{params[:key]}%")).all.page params[:page]
      #             else
      #               Student.without_deleted.page params[:page]
      #             end
    end

    def show
      @student = Student.without_deleted.find(params[:id])

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
      # logging
      Rails.logger.info 'New student accessed'
    end

    def create
      @student = Student.new student_params
      if @student.save
        flash[:success] = 'Created success!'
        redirect_to new_manager_student_path
        UserMailer.with(student_params).welcome_email.deliver_later
      else
        flash[:error] = 'Created failed!'
        render :new
        # redirect_to new_manager_student_path
      end
    end

    def update
      @student = Student.find(params[:id])
      # @grade = Grade.find_by(student_id: params[:id])
      respond_to do |format|
        if @student.update!(student_params)
          format.html { redirect_to edit_manager_student_url(@student), notice: 'Student was successfully updated.' }
          format.json { render :edit, status: :ok, location: @student }
        else
          format.html { render :edit }
          format.json { render json: @student.errors, status: :unprocessable_entity }
        end
      end
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

    def destroyed
      @students = Student.only_deleted
    end

    def restore
      @student = Student.only_deleted.find(params[:id])
      @student.restore(recursive: true)
      redirect_to destroyed_manager_students_path
    end

    def really_delete
      @student = Student.only_deleted.find(params[:id])
      @student.really_destroy!
      redirect_to destroyed_manager_students_path
    end

    private

    def student_params
      params.require(:student).permit(:firstname, :lastname, :phone, :address, :avatar, :video, :audio,
                                      grades_attributes: %i[id subject score semester comments])
    end

    def update_params
      params.require(:student).permit(:firstname, :lastname, :phone, :address, :avatar, :video, :audio,
                                      grades_attributes: %i[id subject score semester comments])
    end

    def delete_params
      params.permit(:id)
    end
  end
end
