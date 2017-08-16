class Votacion < ApplicationRecord
require 'net/http'
	
	def self.set_votacion
		  Votacion.delete_all
		  url_terminal = "http://104.131.40.8/votacion_show_json"
	      url = URI.parse(url_terminal)
	      req = Net::HTTP::Get.new(url.to_s)
	      res = Net::HTTP.start(url.host, url.port) {|http|
	        http.request(req)
	      }
	      
	      @votacion = JSON.parse res.body
	      v = Votacion.new
	      v.razon = @votacion["razon"]
	      v.inicio= @votacion["inicio"]
	      v.finalizacion = @votacion["finalizacion"]
	      v.etapa = @votacion["etapa"]
	      v.balotas = @votacion["balotas"]
	      v.save
	end
end
