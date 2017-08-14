class Voto < ApplicationRecord
	before_create :set_votante
	require 'json'
	def set_votante
		cmd = "multichain-cli cadena getnewaddress"
		res = %x[#{cmd}]
		self.direccion_votante =  res
	end

	def self.listo_para_votar
		cmd = "multichain-cli cadena gettotalbalances"
		res = %x[#{cmd}]
		json_obj = res.delete("/n").delete(" ")
		new_obj = JSON.parse json_obj
		if new_obj.nil?
			return false
		end
		return new_obj.first["qty"].to_i >0
	end

	def self.emitir_voto(direccion_opcion)
		s = Estado.last.id_en_linea.to_s
		cmd = "multichain-cli cadena sendwithdatafrom " + Voto.last.direccion_votante.to_s.strip  + " " + direccion_opcion.to_s.strip + " '{" + '"balotas"' + ":1}' " + "'{" + '"for":"root","key":' + '"'+ direccion_opcion + '","data":"' + s.unpack('U'*s.length).collect {|x| x.to_s 16}.join.to_s + '"' + "}'"
		res = %x[#{cmd}]
	end
end
