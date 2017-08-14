class WelcomeController < ApplicationController
  require 'net/http'
  def index
  	if Estado.all.count == 0
  		estado = Estado.new
  		estado.estado = "esperando"
  		estado.save
  	end
  	if Estado.first.estado == "votando"
      @blockchain_problem =  !Voto.listo_para_votar
      @partidos = Partido.all
      @votacion = Votacion.first
  		render "votando" ,:layout => false
  	else
  		render "index"
  	end
  end

  def hablitar_papeleta
    Estado.cambiar_estado("votando")
    voto = Voto.new
    voto.save
    encoded_url = URI.encode('http://104.131.40.8/informar_direccion/' + voto.direccion_votante)
    url = URI.parse(encoded_url)
    req = Net::HTTP::Get.new(url.to_s)
    res = Net::HTTP.start(url.host, url.port) {|http|
      http.request(req)
    }
    ActionCable.server.broadcast "refrescar", :event => "Refrescar" 
  end

  def votar
    if Voto.listo_para_votar
      Estado.cambiar_estado("esperando")
      (0..Votacion.first.balotas).each do |counter|
        param = "direccion_partido_" + counter.to_s 
        Voto.emitir_voto(params[param.to_sym])
        url = URI.parse('http://104.131.40.8/finalizar_voto/' + Estado.first.id_en_linea.to_s + '/' + Estado.first.user_id.to_s)
        req = Net::HTTP::Get.new(url.to_s)
        res = Net::HTTP.start(url.host, url.port) {|http|
          http.request(req)
        }
      end
    end
    redirect_to :root
  end

  def set_id_en_linea
    Partido.set_partidos
    Votacion.set_votacion
    Estado.set_id_en_linea(params[:id_mesa],params[:id_user])
    ActionCable.server.broadcast "refrescar", :event => "Refrescar" 
  end
end

