class Partido < ApplicationRecord
	has_many :opcions
	require 'net/http'
	
	def self.set_partidos
		  Partido.delete_all
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


	      @partidos.each do |partido|
	      	p = Partido.new
	      	p.nombre = partido["nombre"]
	      	p.informacion = partido["informacion"]
	      	p.color = partido["color"]
	      	p.color_secundario = partido["color_secundario"]
	      	p.save
	      end

	      @opcions.each do |opcion|
	      	o = Opcion.new
	      	o.nombre = opcion["nombre"]
	      	o.informacion = opcion["informacion"]
	      	o.partido_id = opcion["partido_id"].to_i
	      	o.direccion = opcion["direccion"]
	      	o.save
	      end

	end
end
