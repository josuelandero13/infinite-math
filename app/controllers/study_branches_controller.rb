class StudyBranchesController < ApplicationController
  def index
    @studys_branches = StudyBranch.all
  end

  def theory_study_branch
    @study_branch = StudyBranch.find(params[:study_branch_id])
    @study_units = StudyUnit.where(id: params[:study_unit_id])
  end

  def study_units
    study_units = StudyUnit.where(
      study_branch_id: params[:study_branch_id]
    ).pluck(:id, :name)

    render json: study_units
  end

  def show
    @study_branch = StudyBranch.find(
      params[:id]
    )
  end

  def new
    @study_branch = StudyBranch.new
  end

  def create
    msg_create = 'La rama de estudio se ha creado exitosamente.'
    @study_branch = StudyBranch.new(study_branch_params)

    return redirect_to study_branches_path, notice: msg_create if @study_branch.save

    render :new, status: :unprocessable_entity
  end

  def edit
    @study_branch = StudyBranch.find(params[:id])
  end

  def update
    @study_branch = StudyBranch.find(params[:id])

    return render :edit, status: :unprocessable_entity unless @study_branch.update(study_branch_params)

    redirect_to study_branches_path, notice: 'La rama de estudio se ha actualizado exitosamente'
  end

  def destroy
    @study_branch = StudyBranch.find(params[:id])

    @study_branch.destroy

    redirect_to study_branches_path, notice: 'Se elimino exitosamente la rama de estudio', status: :see_other
  end

  private

  def study_branch_params
    params.require(:study_branch).permit(:name, :score, :course_id)
  end
end
