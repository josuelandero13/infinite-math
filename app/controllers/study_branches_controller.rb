class StudyBranchesController < ApplicationController
  skip_before_action :protect_pages, only: %i[
    index theory_study_branch study_unit_options
  ]
  def index
    @study_branches = StudyBranch.all
  end

  def theory_study_branch
    @study_branch = StudyBranch.find(params[:study_branch_id])
    @study_unit = StudyUnit.find(params[:study_unit_id]) if params[:study_unit_id].present?
    @exercises = Exercise.where(study_unit_id: @study_unit.id) if @study_unit.present?
  end

  def study_unit_options
    study_units = StudyUnit.where(
      study_branch_id: params[:study_branch_id]
    ).pluck(:id, :name)

    render json: study_units
  end

  def show
    study_branch
  end

  def new
    @study_branch = StudyBranch.new
  end

  def create
    @study_branch = StudyBranch.new(study_branch_params)

    return redirect_to study_branches_path, notice: t('.created') if @study_branch.save

    render :new, status: :unprocessable_entity
  end

  def edit
    study_branch
  end

  def update
    return render :edit, status: :unprocessable_entity unless study_branch.update(study_branch_params)

    redirect_to study_branches_path, notice: t('.updated')
  end

  def destroy
    linked_branch = study_branch.study_units.any?

    return redirect_to study_branch_path(study_branch), alert: t('.linked_branch') if linked_branch

    study_branch.destroy
    redirect_to study_branches_path, notice: t('.destroyed'), status: :see_other
  end

  private

  def study_branch_params
    params.require(:study_branch).permit(:name, :score, :course_id)
  end

  def study_branch
    @study_branch = StudyBranch.find(params[:id])
  end
end
