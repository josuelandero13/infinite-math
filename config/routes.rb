# frozen_string_literal: true

Rails.application.routes.draw do
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  root 'homepage#index'

  resources :study_branches
  get 'study_branches_general', to: 'study_branches#mostrar_studys_branches'
  get 'obtener_study_units', to: 'study_branches#study_units'

  resources :study_units

  resources :calculators, only: %i[index show] do
    collection do
      get 'sum'
      get 'subtract'
      get 'multiply'
      get 'divide'
    end
  end
end
