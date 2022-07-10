Rails.application.routes.draw do
  mount Mailkick::Engine => "/mailkick"
end

Mailkick::Engine.routes.draw do
  resources :subscriptions, only: [:show], path: "mailkick/subscriptions" do
    get :unsubscribe, on: :member
    get :subscribe, on: :member
  end
end
