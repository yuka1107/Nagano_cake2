Rails.application.routes.draw do
  devise_for :admins,controllers: {sessions: 'admins/sessions' }
  devise_for :customers

end
