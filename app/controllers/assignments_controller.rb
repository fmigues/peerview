class AssignmentsController < ApplicationController
  before_action :set_assignment, only: [:show, :edit, :update, :destroy]
  before_action :set_teacher, except: [:show]
  def index
    @assignments = Assignment.all
    # @assignments = Assignment.all.where(@assignment.deadline < Date.today)

  end

  def show
    @current_student = current_student


  end

  def new
    @assignment = Assignment.new
  end

  # def my_assignments
  #   @assignments = Assignment.where(deadline: == Date.today)
  # end

  def create
    @assignment = Assignment.new(assignment_params)
    @assignment.teacher = @teacher
    # @assignment.student_id = current_student
    if @assignment.save
      EvaluationProcessService.new(@assignment).call
      redirect_to teacher_path(@teacher)
    else
      render :new
    end
  end

  def edit
  end

  def update
    @assignment.update(params[:assignment])
    redirect_to teacher_assignment_path(@assignment)
  end

  def destroy
    @assignment.destroy
    redirect_to teacher_assignments_path
  end

  private
  def set_teacher
    @teacher = Teacher.find(params[:teacher_id])
  end
  def set_assignment
    @assignment = Assignment.find(params[:id])
  end

  def assignment_params
    params.require(:assignment).permit(:name, :deadline, :description, :status, :evaluation_id, :classroom_id, :teacher_id, :specs, :topic_id, :attachment, :attachment_cache)
  end
end
