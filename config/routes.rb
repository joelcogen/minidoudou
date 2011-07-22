Minidoudou::Application.routes.draw do

  match "userlist", :to => "userlist#index"
  match "userlist/:id/delete", :to => "userlist#delete", :via => "delete", :as => "user_delete"
  match "userlist/:id/toggleadmin", :to => "userlist#toggleadmin", :as => "admin_toggle"

  devise_for :users

  resources :apks

  resources :packages
  
  resources :devices do
    resources :base_roms do
      resources :base_rom_packages
      resources :configurations
      get 'purge_configs'
      get 'purge_test_configs'
    end
  end

  root :to => "devices#index"

end

