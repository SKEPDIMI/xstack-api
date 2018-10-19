Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  
  post '/upload/user' => 'uploads#user_img'
  
  namespace :v1 do
    post '/contact' => 'mailer#contact'
  end
end
