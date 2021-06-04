Rails.application.routes.draw do

  # Mostrará todas as rotas do recurso portfolios, menos para :show
  resources :portfolios, except: [:show]

  # Rota personalizada para acessar portfolio_items com subtitle de 'Angular'
  # controller responsável pelo método de ação -> portfolios
  # método de ação responsável por mostrar items com subtitle 'Angular' -> angular
  get 'angular-items', to: 'portfolios#angular'

  # Rota personalizada para acessar portfolio_items com subtitle de 'Ruby on Rails'
  # controller responsável pelo método de ação -> portfolios
  # método de ação responsável por mostrar items com subtitle 'Ruby on Rails' -> ruby_on_rails
  get 'ruby-items', to: 'portfolios#ruby_on_rails'

  # Rota personalizada para não acessar portfolios/:id, mas sim portfolio/:id. Portfolio no singular
  # to: 'controller#action' responsável pela rota
  # as: 'portfolio_show' como a rota será chamada para exibir a página show (está sendo chamada dentro de index.html.erb)
  get 'portfolio/:id', to: 'portfolios#show', as: 'portfolio_show'

  get 'about-me', to: 'pages#about'
  get 'contact', to: 'pages#contact'

  resources :blogs do
    member do # cria uma rota membro chamada toggle_status_blog_path dentro do recurso de rotas do blogs
      get :toggle_status
    end
  end

  root to: 'pages#home'
end
