Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      resources :products, only: [:index, :show] do
        member do
          post 'purchase' => 'products#purchase'
        end
      end

      resources :carts, only: [:index, :show, :create] do
        member do
          post 'complete' => 'carts#complete'
          post 'add' => 'carts#add'
        end
      end

      resources :orders
    end
  end
end
