class StudyUnitsController < ApplicationController
  def index
    @study_units = StudyUnit.all
  end

  def show
    @study_unit = StudyUnit.find(
      params[:id]
    )
  end

  def new
    @study_unit = StudyUnit.new
  end

  def create
    msg_create = 'La unidad de estudio se ha creado exitosamente.'
    @study_unit = StudyUnit.new(study_unit_params)

    return redirect_to study_units_path, notice: msg_create if @study_unit.save

    render :new, status: :unprocessable_entity
  end

  def edit
    @study_unit = StudyUnit.find(params[:id])
  end

  def update
    @study_unit = StudyUnit.find(params[:id])

    return render :edit, status: :unprocessable_entity unless @study_unit.update(study_unit_params)

    redirect_to study_units_path, notice: 'La rama de estudio se ha actualizado exitosamente'
  end

  def destroy
    @study_unit = StudyUnit.find(params[:id])

    @study_unit.destroy

    redirect_to study_units_path, notice: 'Se elimino exitosamente la unidad de estudio', status: :see_other
  end

  private

  def study_unit_params
    params.require(:study_unit).permit(:unit_number, :name, :study_branch_id, :content)
  end
end
