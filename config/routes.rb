Rails.application.routes.draw do
  root to: 'visitors#index'
  devise_for :users
  resources :users

  get 'user/listing' => 'users#listing', as: :users_listing
  get 'user/approve/:id' => 'users#approve', as: :user_approve
  get 'user/disapprove/:id' => 'users#disapprove', as: :user_disapprove

  # mailbox folder routes
  get "mailbox/inbox" => "mailbox#inbox", as: :mailbox_inbox
  get "mailbox/sent" => "mailbox#sent", as: :mailbox_sent
  get "mailbox/trash" => "mailbox#trash", as: :mailbox_trash

  # conversations
  resources :conversations do
    member do
      post :reply
      post :trash
      post :untrash
    end
  end
  
end
