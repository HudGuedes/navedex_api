Rails.application.routes.draw do
  devise_for :users,
              path: '',
              path_names: {
                 sign_in: 'login',
                 sign_out: 'logout',
                 registration: 'signup'
               },
              controllers: {
                registrations: 'users/registrations',
                sessions: 'users/sessions' 
              }
  resources :navers
  resources :projects
end
