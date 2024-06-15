class StudyUnitsController < ApplicationController
  def index
    @study_units = StudyUnit.all
  end

  def show
    study_unit
  end

  def new
    @study_unit = StudyUnit.new
  end

  def create
    @study_unit = StudyUnit.new(study_unit_params)

    return redirect_to study_units_path, notice: t('.created') if @study_unit.save

    render :new, status: :unprocessable_entity
  end

  def edit
    study_unit
  end

  def update
    return render :edit, status: :unprocessable_entity unless study_unit.update(study_unit_params)

    redirect_to study_units_path, notice: t('.updated')
  end

  def destroy
    study_unit.destroy

    redirect_to study_units_path, notice: t('.destroyed'), status: :see_other
  end

  private

  def study_unit_params
    params.require(:study_unit).permit(
      :unit_number, :name, :study_branch_id, :content
    )
  end

  def study_unit
    @study_unit = StudyUnit.find(params[:id])
  end
end
