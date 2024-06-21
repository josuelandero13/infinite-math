require 'test_helper'

class ExercisesControllerTest < ActionDispatch::IntegrationTest
  setup do
    login

    @exercise = exercises(:ejercicio1)
  end

  test 'should get edit' do
    get edit_exercise_path(@exercise)

    assert_response :success
  end

  test 'should update exercise' do
    patch exercise_path(@exercise), params: { exercise: { title: 'Updated Title' } }
    assert_redirected_to study_unit_path(@exercise.study_unit)
    @exercise.reload
    assert_equal 'Updated Title', @exercise.title
  end

  test 'should create exercise' do
    assert_difference('Exercise.count') do
      post exercises_path, params: {
        exercise: {
          title: 'New Exercise',
          correct_answer: 'New Answer',
          study_unit_id: study_units(:unidad1).id
        }
      }
    end

    assert_redirected_to study_unit_path(study_units(:unidad1))
  end

  test 'should not create exercise with invalid params' do
    assert_no_difference('Exercise.count') do
      post exercises_path, params: { exercise: { title: '' } }
    end
    assert_response :unprocessable_entity
  end

  test 'should destroy exercise' do
    assert_difference('Exercise.count', -1) do
      delete exercise_path(@exercise)
    end

    assert_redirected_to study_units_path
  end
end
