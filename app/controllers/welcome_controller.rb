class WelcomeController < ApplicationController
  require 'net/http'
  def index
  	if Estado.all.count == 0
  		estado = Estado.new
  		estado.estado = "esperando"
  		estado.save
  	end

    url_terminal = "http://104.131.40.8/votacion_show_json"
      url = URI.parse(url_terminal)
      req = Net::HTTP::Get.new(url.to_s)
      res = Net::HTTP.start(url.host, url.port) {|http|
        http.request(req)
    }
    
    @votacion = JSON.parse res.body

  	if Estado.get_estado() == "votando"
      url_terminal = "http://104.131.40.8/partidos_index_json"
      url = URI.parse(url_terminal)
      req = Net::HTTP::Get.new(url.to_s)
      res = Net::HTTP.start(url.host, url.port) {|http|
        http.request(req)
      }
      
      @partidos = JSON.parse res.body

      url_terminal = "http://104.131.40.8/opcions_index_json"
      url = URI.parse(url_terminal)
      req = Net::HTTP::Get.new(url.to_s)
      res = Net::HTTP.start(url.host, url.port) {|http|
        http.request(req)
      }

      @opcions = JSON.parse res.body
  		render "votando" ,:layout => false
  	else
  		render "index"
  	end
  end

  def hablitar_papeleta
    Estado.cambiar_estado("votando")
    ActionCable.server.broadcast "refrescar", :event => "Refrescar" 
  end

  def votar
    url = URI.parse('http://104.131.40.8/finalizar_voto/' + Estado.first.id_en_linea.to_s + '/' + Estado.first.user_id.to_s)
    req = Net::HTTP::Get.new(url.to_s)
    res = Net::HTTP.start(url.host, url.port) {|http|
      http.request(req)
    }
    logger.debug res
    Estado.cambiar_estado("esperando")
    redirect_to :root
  end

  def set_id_en_linea
    Estado.set_id_en_linea(params[:id_mesa],params[:id_user])
    ActionCable.server.broadcast "refrescar", :event => "Refrescar" 
  end
end

