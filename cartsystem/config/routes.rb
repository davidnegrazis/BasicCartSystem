Rails.application.routes.draw do
    namespace 'api' do
        namespace 'v1' do
            resources :products, only: [:index, :show] do
                member do
                    patch 'purchase' => 'products#purchase'
                end
            end

            resources :carts, only: [:index, :show, :create] do
                member do
                    patch 'complete' => 'carts#complete'
                    patch 'add' => 'carts#add'
                end
            end

            resources :orders do
                member do
                    get 'nodes' => 'orders#nodes'
                end
            end
            resources :order_deliveries
        end
    end
end
