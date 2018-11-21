Rails.application.routes.draw do
  resources :records, only: %i[index create], defaults: { format: :json }
end
