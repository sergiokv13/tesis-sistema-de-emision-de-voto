class Voto < ApplicationRecord
	before_create :set_votante
	def set_votante
		cmd = "multichain-cli cadena getnewaddress"
		res = %x[#{cmd}]
		self.direccion_votante =  res
	end

	def self.emitir_voto(direccion_partido)
		s = direccion_partido
		cmd = "multichain-cli cadena sendwithdatafrom " + Voto.last.direccion_votante.to_s.strip  + " " + direccion_partido.to_s.strip + " '{" + '"balotas"' + ":1}' " + "'{" + '"for":"root","key":' + '"mesa'+ Estado.last.id_en_linea.to_s + '","data":"' + s.unpack('U'*s.length).collect {|x| x.to_s 16}.join.to_s + '"' + "}'"
		puts "DIRECCIOOOOOON-" + cmd
		res = %x[#{cmd}]
	end
end
