Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      resources :products, only: [:index, :show] do
        member do
          post 'purchase' => 'products#purchase'
        end
      end
    end
  end
end
