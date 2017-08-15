Rails.application.routes.draw do
  get 'welcome/index'
  root "welcome#index"
  get '/habilitar_papeleta' => "welcome#hablitar_papeleta"
  post '/votar' => "welcome#votar"
  get '/set_id_en_linea/:id_mesa/:id_user' => "welcome#set_id_en_linea"
  get '/estado_blockchain' => "welcome#estado_blockchain"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
