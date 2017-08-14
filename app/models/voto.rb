class Voto < ApplicationRecord
	before_create :set_votante
	def set_votante
		cmd = "multichain-cli cadena getnewaddress"
		res = %x[#{cmd}]
		self.direccion_votante =  res
	end

	def self.emitir_voto(direccion_partido)
		s = Estado.first.id_en_linea.to_s
		cmd = "multichain-cli cadena sendwithdatafrom " + direccion_partido + " " + Voto.last.direccion_partido + " '{" + '"balotas"' + ":1}' " + "'{" + '"for":"root","key":"mesa1","data":"' + s.unpack('U'*s.length).collect {|x| x.to_s 16}.join + '"' + "}'"
		res = %x[#{cmd}]
		self.direccion_votante =  res
	end
end
