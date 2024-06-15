require "test_helper"

class StudyUnitsControllerTest < ActionDispatch::IntegrationTest
  def setup
    login

    @geometria = study_branches(:geometria)
    @unidad1 = study_units(:unidad1)
    @unidad2 = study_units(:unidad2)
  end

  test 'should get index' do
    get study_units_path
    assert_response :success

    assert_match @unidad1.name, @response.body
    assert_match @unidad2.name, @response.body
  end

  test 'should show study unit' do
    get study_unit_path(@unidad1)
    assert_response :success

    assert_match @unidad1.name, @response.body
    assert_match @unidad1.study_branch.name, @response.body
  end

  test 'should get new' do
    get new_study_unit_path

    assert_response :success
    assert_select 'form'
  end

  test 'I should create a new unit of study' do
    assert_difference('StudyUnit.count', 1) do
      post study_units_path, params: {
        study_unit: {
          name: 'Unidad5', unit_number: 5,
          study_branch_id: study_branches(:geometria).id
        }
      }
    end

    assert_redirected_to study_units_path
    assert_equal 'La unidad de estudio se ha creado exitosamente.', flash[:notice]
  end

  test 'should get edit' do
    get edit_study_unit_path(@unidad1)

    assert_response :success
    assert_select 'form'
  end

  test 'should update study unit' do
    patch study_unit_path(@unidad1), params: {
      study_unit: {
        name: 'Unidad Avanzada', unit_number: 6,
        study_branch_id: study_branches(:estadistica).id
      }
    }

    assert_redirected_to study_units_path
    assert_equal 'La unidad de estudio se ha actualizado exitosamente.', flash[:notice]
    @unidad1.reload
    assert_equal 'Unidad Avanzada', @unidad1.name
  end

  test 'can delete study unit' do
    assert_difference('StudyUnit.count', -1) do
      delete study_unit_path(@unidad1)
    end

    assert_redirected_to study_units_path
    assert_equal flash[:notice], 'La unidad de estudio se elimino exitosamente.'
  end
end
