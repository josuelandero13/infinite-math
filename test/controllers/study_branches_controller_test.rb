# frozen_string_literal: true

require 'test_helper'

class StudyBranchesControllerTest < ActionDispatch::IntegrationTest
  def setup
    login

    @geometria = study_branches(:geometria)
    @calculo = study_branches(:calculo)
    @unidad1 = study_units(:unidad1)
    @unidad2 = study_units(:unidad2)
  end

  test 'should get index' do
    get study_branches_path
    assert_response :success

    assert_match @geometria.name, @response.body
    assert_match @calculo.name, @response.body
  end

  test 'should get theory_study_branch' do
    get study_branches_general_path, params: {
      study_branch_id: @geometria.id, study_unit_id: @unidad1.id
    }
    assert_response :success

    assert_match @geometria.name, @response.body
    assert_match @unidad1.name, @response.body
  end

  test 'should get study_units as JSON' do
    post study_unit_options_path, params: { study_branch_id: @geometria.id }
    assert_response :success
    assert_equal 'application/json; charset=utf-8', @response.content_type

    expected_response = [
      [@unidad1.id, @unidad1.name],
      [@unidad2.id, @unidad2.name]
    ].to_json
    assert_equal expected_response, @response.body
  end

  test 'should show study_branch' do
    get study_branch_path(@geometria)
    assert_response :success
  end

  test 'should get new' do
    get new_study_branch_path

    assert_response :success
    assert_select 'form'
  end

  test 'should create study_branch' do
    assert_difference('StudyBranch.count', 1) do
      post study_branches_path, params: {
        study_branch: {
          name: 'Algebra', course_id: courses(:math).id
        }
      }
    end

    assert_redirected_to study_branches_path
    assert_equal 'La rama de estudio se ha creado exitosamente.', flash[:notice]
  end

  test 'should get edit' do
    get edit_study_branch_path(@geometria)
    assert_response :success
  end

  test 'should update study_branch' do
    patch study_branch_path(@geometria), params: {
      study_branch: {
        name: 'Geometría Avanzada', course_id: @geometria.course_id
      }
    }

    assert_redirected_to study_branches_path
    assert_equal 'La rama de estudio se actualizado exitosamente.', flash[:notice]
    @geometria.reload
    assert_equal 'Geometría Avanzada', @geometria.name
  end

  test 'can delete study branch' do
    assert_difference('StudyBranch.count', -1) do
      delete study_branch_path(study_branches(:estadistica))
    end

    assert_redirected_to study_branches_path
    assert_equal flash[:notice], 'La rama de estudio se elimino exitosamente.'
  end
end
