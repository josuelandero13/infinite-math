# frozen_string_literal: true

class ExercisesController < ApplicationController
  skip_before_action :protect_pages, only: %i[
    check_answer
  ]
  def show
    @exercise = Exercise.find(params[:exercise_id])
  end

  def edit
    exercise
  end

  def update
    return render :edit, status: :unprocessable_entity unless exercise.update(exercise_params)

    redirect_to study_unit_path(exercise.study_unit), notice: t('.updated')
  end

  def new
    @exercise = Exercise.new
  end

  def create
    @exercise = Exercise.new(exercise_params)

    return redirect_to study_unit_path(@exercise.study_unit), notice: t('.created') if @exercise.save

    render :new, status: :unprocessable_entity
  end

  def check_answer
    correct_answer = Exercise.find_by(
      id: params[:exercise_id]
    ).correct_answer

    render json: {
      correct: params[:answer] == correct_answer,
      correct_answer:
    }
  end

  def destroy
    exercise.destroy

    redirect_to study_units_path, notice: t('.destroyed'), status: :see_other
  end

  private

  def exercise_params
    params.require(:exercise).permit(
      :title, :correct_answer, :study_unit_id, :content
    )
  end

  def exercise
    @exercise = Exercise.find(params[:id])
  end
end
